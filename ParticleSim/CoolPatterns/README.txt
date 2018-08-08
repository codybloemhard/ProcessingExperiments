An explanation on what this is and why it is (here).

As i experiment to make a simulator with some particles to see if i can
make something similair to conways game of life, but with different rules
for multiple types of cells or particles.

I started with a cell that divides itself to its four neighbour cells.
Every cell has energy. If a neighbour cell already has energy it just adds to it.

As known like with the game of life, you update into a new buffer. In this 
context, let us take a cell that divides at (2,2) with energy(e) of 16.
to left it creates a cell at (3,2) with e = 4.
If you do not update into a new buffer then this newly spawned cell can be updated
in the same tick when the update order is from left to right.

I did not use a new buffer, and it updates the column from left to right.
This creates not a patterns with 4 equal symmetric parts but a patterns with
only 2 symmetric parts.

It begins as a blob but as the system loses energy, more holes appear and
very interesting patterns appear, looking like 8bit aliens from a old and
well known game. After that is loses to much energy and dies off.