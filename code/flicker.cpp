/*
 * flicker_t20.cpp
 * A port of this algorithm: https://github.com/emilyvelasco/flickery_light/blob/main/flickery_light_w_warmup.ino
 * Important datasheet: http://ww1.microchip.com/downloads/en/DeviceDoc/atmel-8235-8-bit-avr-microcontroller-attiny20_datasheet.pdf
 *
 * When PA2 is High-Z, current is shunted through TLVH431
 * and LED anode is driven to approximately 2V.
 *
 * When PA2 is LOW, TLV431 is driven as high as possible
 * and current flows through the LED as normal.
 *
 * When PA2 is HIGH, the LED anode is driven to 1.24V
 * which will cause the system to reset. Not advised.
 *
 * Created: 1/16/2022 3:35:08 PM
 * Author : Sam Ettinger <ettingersam@gmail.com> https://github.com/settinger/custom-flicker-LED
 */
#define F_CPU 4000000UL
#include <avr/io.h>
#include <avr/interrupt.h>

// Declare constants and variables
#define INTERRUPT_DELAY 100U                            // Number of processor cycles in the smallest binary code modulation frame
#define NUM_FRAMES 6                                    // Number of binary code modulation frames per period
#define UPDATE_DELAY 20                                 // Number of periods to elapse before re-calculating the LED brightness
volatile unsigned int interruptDelay = INTERRUPT_DELAY; // How many cycles long is the current frame; loops between 100, 200, 400, 800, 1600, 3200
volatile int frame = 0;                                 // Which binary-code-modulation frame we are currently on; loops between 0, 1, 2, 3, 4, 5
volatile unsigned int brightness = 0;                   // A value between 0 and 63 determining the duty cycle of the LED (0: off, 63: fully on)
volatile unsigned char updateDelay = 0;                 // How many periods of binary code modulation have elapsed since LED brightness was last calculated

volatile unsigned int randomLevel;                      // A random number to determine if LED is on or not
volatile unsigned int lightLevel;                       // A random number that is the LED brightness
volatile unsigned int cutoffValue = 127;                // By comparing this to a random 7-bit number we determine how likely the LED is to be on or off at a given moment.
volatile unsigned int bottomRandom = 2;                 // The lowest acceptable brightness for the LED at this current moment
volatile bool foo = false;                              // Slows down the speed at which cutoffValue and bottomRandom decrease/increase, respectively

// Write to the 16-bit register pair OCR1A
void setTimer1(unsigned int i) {
	unsigned char sreg;
	sreg = SREG; // Save global interrupt flag
	cli(); // Disable interrupts
	OCR1A = i; // Write value to register pair
	TCNT1 = 0; // Reset counter
	SREG = sreg; // Restore global interrupt flag
}

// Set the LED to one of 64 brightness levels
void setBrightness (unsigned int i) {
	brightness = i & 0x3F;
}

// Gather entropy from ADC
int getEntropy(int bits) {
	int entropy = 0;
	for (int bit = 0u; bit < bits; bit++) {
		// Start ADC collection
		ADCSRA |= 1 << ADSC;
		// Wait for ADC conversion to finish (25 clock cycles the first time, 13 cycles afterward)
		while (ADCSRA & 1 << ADSC) {
			;
		}
		// Fetch LSB of ADC result and put it in the entropy variable
		entropy |= (ADC & 1) << bit;
		
		// Delay a little bit before taking next measurement
		if (bit < (bits - 1)) {
			int n = 0;
			while (n < 30) {
				n++;
			}
		}
	}
	return entropy;
}

// Calculate the new brightness
void flicker() {
	// Pick random number to determine if light is on or off
	randomLevel = getEntropy(7);
	
	// Lower cutoff level over time to reduce flicker gradually
	if (foo) {
		if (cutoffValue > 0) {
			cutoffValue--;
		}
	}
	
	// If LED should be on, set it to the calculated brightness
	if (randomLevel >= cutoffValue) {
		lightLevel = getEntropy(5);
		lightLevel = bottomRandom + (lightLevel % (63 - bottomRandom)); //bottomRandom + (lightLevel & (63-bottomRandom)); // 
		setBrightness(lightLevel);
	} else {
		setBrightness(0);
	}
	
	// Increase minimum brightness value until full brightness is achieved, but maintain some flicker
	foo = !foo;
	if (foo) {
		bottomRandom++;
		if (bottomRandom > 50) {
			bottomRandom = 50;
		}
	}
}

int main(void) {
	// Set clock prescaler to 4 (i.e. 2 MHz system clock) (Datasheet p.21)
	CCP = 0xD8;
	CLKPSR = 0b0001;
	
	// Set PA2 to high-Z condition initially (Datasheet p.44)
//	PORTCR = 1 << BBMA; // Break-before-make enabled; I don't know if this helps at all
	DDRA = 0;           // All Port A pins configured as inputs
	PORTA = 0;          // All Port A pins driven low; probably not necessary
	PUEA = 0;	        // All Port A pullup resistors disconnected; putting all Port A pins into High-Z mode
	
	// Configure Timer1 to CTC Mode (datasheet p.96)
	TCCR1A = 0b00 << WGM10;
	TCCR1B = 0b01 << WGM12 | 0b001 << CS10; // no prescaler
	TIMSK = 1 << OCIE1A; // Enable Timer1 Output Compare A Match Interrupt
	
	// Enable ADC for gathering entropy -- PA4 and PA6 are not connected to anything, so probably good choices (datasheet p.121)
	ADCSRA = 1 << ADEN | 0b011 << ADPS0; // Enable ADC, set to 500kHz
	//ADCSRB = 1 << ADLAR; // Left-adjust ADC for faster, less accurate readings
	ADMUX = 0b0110 << MUX0; // Connect ADC to PA6
	
	// Write to the 16-bit OCR1A register pair to set number of cycles before first overflow interrupt occurs (datasheet p.96)
	setTimer1(interruptDelay);
	
	// Set initial brightness
	setBrightness(0);
	
	// Enable interrupts
	sei();
	
	while (1) {
	}
}

/* Timer1 Overflow Interrupt:
 * Interrupt is triggered after n system clock cycles,
 * where n loops between [100, 200, 400, 800, 1600, 3200].
 * If LED is supposed to be ON, write 1<<DDA2 to DDRA register.
 * If LED is supposed to be OFF, write 0<<DDA2 to DDRA register.
 * Every few 3200-cycle interrupts, update brightness
 */

ISR(TIM1_COMPA_vect) {
	// Disable interrupts during this!
	unsigned char sreg;
	sreg = SREG; // Register of global interrupt flags
	cli();       // Disable interrupts
	
	// Advance to next frame
	// If the coming frame will be the last frame of a BCM period,
	// then check if it's time to update the LED brightness.
	// If the coming frame is the first frame of a BCM period, 
	// set the interrupt delay back to its original (low) value.
	// These could be combined into one if statement, I'm sure.

	frame = (frame+1) % NUM_FRAMES;
	
	if (frame == NUM_FRAMES-1) {
		updateDelay++;
		if (updateDelay == UPDATE_DELAY) {
			updateDelay = 0;
			
			// brightness change here
			flicker();
		}
	}
	
	if (frame == 0) {
		interruptDelay = INTERRUPT_DELAY;
	} else {
		interruptDelay = interruptDelay << 1;
	}

	// Turn LED on or off for this frame of binary code modulation
	if (brightness & 1<<frame) {
		DDRA |= 1 << DDA2;
	} else {
		DDRA &= ~(1 << DDA2);
	}
	
	setTimer1(interruptDelay);
	
	SREG = sreg; // Restore interrupts
}