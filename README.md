# Gamemaker-Timescale

GM-TIMESCALE

Provides functions and underlying systems that make slow-motion and time-freeze effects possible.

The "Time Layer" system allows scale values to be assigned to various time layers. All update code can be multiplied by these scale values. Different systems and entities can be assigned to different time layers, thus slow-motion effects can be selectively applied only to certain objects and systems. This way, you can create a game where the player has the ability to slow down the world around them, without impacting themselves or non-diagetic systems such as UI.

Timescale modifeirs can be created to manipulate and manage time layer scales. Once a timescale modifer has been created, a reference is returned which can be used to cancel or manipulate the the associated timescale. Timescale modifiers can act on multiple time layers at the same time, are independent of eachother and stack multiplicatively.
