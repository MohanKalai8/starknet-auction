This project was originally developed as part of CodeHawks' "First Flights" contest, a security auditing competition focused on StarkNet. Due to simultaneous commitments to other audit contests, I was unable to dedicate as much time as I wanted to this project and completed the initial audit and submission within an hour. Despite the time constraint, I identified and reported three high-severity issues out of a total of five high, one medium, and one low severity issues.

In this updated version, I have resolved all identified issues and thoroughly tested the contracts. This was my first expericence to fix all the bugs in the contracts in audit..

To install the openzeppelin library: 

Install the library by declaring it as a dependency in the project’s Scarb.toml file:

[dependencies]
openzeppelin = "0.18.0"