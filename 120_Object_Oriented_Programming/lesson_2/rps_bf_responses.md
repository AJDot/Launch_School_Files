## RPS Bonus Features Responses
### Keeping score

__Right now, the game doesn't have very much dramatic flair. It'll be more interesting if we were playing up to, say, 10 points. Whoever reaches 10 points first wins. Can you build this functionality? We have a new noun -- a score. Is that a new class, or a state of an existing class? You can explore both options and see which one works better.__

This implementation as a state of each person may make sense because each person _has_ a score. This implementation would involve the creation of an instance variable for the `Person` class to keep track of the score of each person. Then score can be kept track of and modified very easily using `Person.score` getter/setter methods. I believe the readability of this code is not great as it puts the logic of updating and comparing score into the `Person` class.
I used `Score` as a collaborator class. I assigned `Score` to the instance variable `@score` of the `Player` class. In this way we can update it easily using methods of the `Score` class and compare them easily using getter methods (`human.score > computer.score`).

### Add a class for each move

__What would happen if we went even further and introduced 5 more classes, one for each move: Rock, Paper, Scissors, Lizard, and Spock. How would the code change? Can you make it work? After you're done, can you talk about whether this was a good design decision? What are the pros/cons?__

This implementation makes the code more readable. When looking at a particular move, I can now focus on what happens when that particular move is made. Any code I change inside of the `Rock` class will not affect the behavior when scissors is selected as a move. This should make the code easier to debug and modify. Most of all (for me) the logic of deciding a winner/loser is much easier to digest when it is split amonst the different subclasses of `Move`.

### Keep track of a history of moves

__As long as the user doesn't quit, keep track of a history of moves by both the human and computer. What data structure will you reach for? Will you use a new class, or an existing class? What will the display output look like?__

I did not use a new class to keep track of the history. I thought of it like each player having a history; it is part of the state of the player. I created an array `history` instance variable in the `Person` class. After every move is made, `[choice, game_number, round_number]` are added to `history`. The output is a table with player choice, computer choice, game number, and round number displayed in columns.

__Revision:__ I thought more about it and ultimately didn't like the code I wrote. Instead, I took history out of the player class because there was duplicate information about the game as a whole. Instead, I made `history` an instance variable of the `RPSGame` class. It is a hash with 4 keys: `:human`, `:computer`, `:game`, `:round`. These are each an array where the new moves for each turn and the game and round numbers are pushed onto their respective keys. This proved to be much simpler and easier to understand.

__Revision 2:__ After another thought, I didn't like the history implementation of the first revision. My previous version made implementing a rule for the computer impossible since the `History` depended on the `Computer` instance and the `Rule` instance (used inside the `Computer` class) depended on the `History` instance. I'm not sure if this circular-like reasoning would actually work but I couldn't wrap my head around it. So I scratched all of the history work and started again. This time I created a `History` class that is not dependent on the instances of the `Player` class. In this way, any rules I create can be dependent on the history of the game and be contained in the `Computer` instance.

### Adjust computer choice based on history

__Come up with some rules based on the history of moves in order for the computer to make a future move. For example, if the human tends to win over 60% of his hands when the computer chooses "rock", then decrease the likelihood of choosing "rock". You'll have to first come up with a rule (like the one in the previous sentence), then implement some analysis on history to see if the history matches that rule, then adjust the weight of each choice, and finally have the computer consider the weight of each choice when making the move. Right now, the computer has a 33% chance to make any of the 3 moves.__

This one has given me a tremendous amount of trouble. I tried for the longest time to create a `Rule` class but I could never make it work. Then I realized that each type of computer player would play by his own rules. So I created subclasses of the `Computer` class to represent each type of computer. So far I have created `Random` - randomly picks a move, `Last Move` - always chooses the humans last move, and `Weighted` - a crude system for choosing a computer move based on the move/wins history. In `Weighted`, every time the computer loses the weights for choosing each move are altered to decrease weight of the move that lost and increase the weight of the 4 other moves evenly. It works ok...

This has taken me a very long time and I think I have lost sight of the fundamentals of OOP; I made this particular exercise too in-depth and basically lost focus.

### Computer personalities

__We have a list of robot names for our Computer class, but other than the name, there's really nothing different about each of them. It'd be interesting to explore how to build different personalities for each robot. For example, R2D2 can always choose "rock". Or, "Hal" can have a very high tendency to choose "scissors", and rarely "rock", but never "paper". You can come up with the rules or personalities for each robot. How would you approach a feature like this?__

After completing this last bonus feature I have redeemed myself a bit. Though the code may be more convoluted than desired, it does work as intended. I have implemented a couple of complex strategies and a couple of easy ones. One strategy (EVE) adjusts the computer's choice based on the history of wins for the human play with the goal of winning each round. Another strategy (Chappie) attempts to tie every round based off of the human's history of moves made. A much simpler version of this is Number 5 - he always chooses the humans last move in an attempt to tie. R2D2 always chooses rock. Hal chooses scissors  a lot, rarely rock, and never paper. Sonny is default - always choose a random move.

After implementing all of these personalities and refactoring the code as best as I could, I feel a bit better. I am certain this is in no way optimized but I am satisfied for now.