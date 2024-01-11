Continuous-Time Markov Chain Modeling of a Wireless LAN

The project revolves around the design and simulation of a wireless local area network (LAN) with three access points, catering to the dynamic connectivity needs of users. The primary objective is to construct a continuous-time Markov chain model to represent the system, simulating the user interactions within the network.

## System Overview:
In this wireless LAN setup, each access point has a maximum capacity of K users, and a user connects to the access point with the strongest signal that is not currently at its maximum capacity. If access point 1 is full, the user attempts to connect to access point 2, and if both are full, the user connects to access point 3. Users connected to access points 2 and 3 can instantly switch to access point 1 when available. Additionally, access point 3 is given priority in switching to access point 1 when both access points 2 and 3 become available simultaneously.

### Key Project Components:

1) Continuous-Time Markov Chain:

Define states representing the number of users at each access point and the state of switches.
Construct a state diagram with transitions based on system rules.
Determine transition rates considering user arrival rates (λ) and service times for access points 1, 2, and 3.

2) MATLAB/Python Simulation:

Implement a simulation model using MATLAB or Python.
Utilize matrices to represent the transition rate matrix and implement logic for state transitions.
Calculate steady-state probabilities for all states.
Compute the probability of blocking a new user in the system.

Emphasis on clear, concise, and well-commented code, along with an understanding of the Markov model's application to the wireless LAN system.

This project not only challenges students to apply their understanding of continuous-time Markov chains but also provides a real-world context for networking concepts, fostering practical skills in simulation and system analysis.

