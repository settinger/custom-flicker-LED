# A different interpretation of "programmable LED"

### Will this work? I have no idea if this will work. It's too goofy to actually work, right? ...Right?

TL;DR I'm investigating if I can attach a very very small circuit to a through-hole LED to run a custom programmed pattern, similar to a candle-flicker LED.

![A 3d render of a 5mm through-hole LED with a small PCB on the underside of the lens](sideside.png)

![A 3d render of a 5mm through-hole LED with a small PCB on the underside of the lens](underside.png)

![The schematic of the aforementioned small PCB](schematic.png)


## The Concept

A flicker LED is an LED that flickers. More specifically, it is a _drop-in replacement_ for a conventional LED—no need to change the current-limiting resistor, no new calculations for forward voltages, it works just the same as a conventional LED. And they're cheap, too! If you want an LED that flickers like a candle (or one that blinks at a set frequency and duty cycle) you are set for life.

But what if you want a different LED light pattern? In my specific case, I want an LED that turns on like a struggling fluorescent bulb. Or one that stays off most of the time, then suddenly lights up the room like lightning. Or a pseudo-status LED that blinks at random frequencies to trick the viewer into thinking some complex process is running. Or...anything, really. A programmable LED!

Do programmable LEDs like this exist? Obviously the WS2812b and similar LEDs exist, and those are frequently called "programmable LEDs". But those are pretty different than, say, a flicker LED. You still need a controller of some variety to tell the WS2812b what pattern to perform, which is not the case for a flicker LED, and not the case for the LEDs I'm envisioning.

## The Circuit

So can it be done? Without designing a custom IC and embedding it in a custom LED casing? I need a solution compatible with a stock LED. And that means the solution needs to exist _in parallel with the LED_. I'm envisioning a small PCB nestled underneath a 5mm through-hole LED. Soldered in place between the existing legs, no cuts or modifications to the LED itself.

When it's fully on, a white LED's forward voltage is around 3.1 volts. That's enough that we could power a microcontroller in parallel with the LED! But when the LED is off, that forward voltage is 0V. But if we keep the forward voltage above roughly 1.8V, we should consistently have enough power to keep a microcontroller on without resorting to boost converters or other power management tools.

What microcontroller is small enough to fit under a 5mm through-hole LED? I know of two: the WLCSP-12 ATtiny20 (1.55×1.43 mm) and the WLP-16 MAX32660 (1.55×1.57 mm). It's true that I've been meaning to get better with ARM systems, but for now I'll stick with the more familiar AVR-based ATtiny20.

We can shunt current around the LED using an NPN transistor controlled by an I/O pin on the microcontroller. A Zener diode keeps the LED voltage at at least 1.8V, so the microcontroller can get power without some kind of boost circuit.

So, when current is flowing through the LED, the microcontroller receives about 3.1 volts. When current isn't flowing through the LED, it receives about 1.8 V. I haven't tried, but I assume the ATtiny20 isn't designed to work with a power supply constantly pinging between these two values. A tiny LDO ensures that, no matter what the diode forward voltage, the ATtiny20 gets enough power.

## Putting it together

This really seems plausible! [Here's a Falstad simulation that makes me optimistic.](https://tinyurl.com/yxa3gy2q) The component count is low enough that I could do it with 0402 passives and a SOT-723 transistor. The microcontroller and LDO are BGA packages, but if I'm careful I _think_ I can hand-solder the rest. They aren't suuuper-convenient sizes, but I'll do it for the sake of this goofy project.

The specific Zener and LDO values need to be verified experimentally; I have several values on the way for a breadboard test. And it looks like I may have to seek out a scalper to get WLCSP-12 ATtiny20 ICs. If you have any spares you could sell to me, please get in touch!

In the meantime, please let me know if I've overlooked some aspect or if you have any ideas on how to change/improve this. I have a few ideas for a 5mm RGB LED, but that's a project for another time....