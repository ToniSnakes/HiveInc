# HiveInc

  HiveInc is an Artificial Intelligence project that I created out of a fascination with evolutionary algorithms and neural networks, wishing to find a way to incorporate both in order to see if very simple organisms could, unknowingly, develop complex behaviors.
  
#### SETUP:
  The world of HiveInc is made out of a 2D plane that loops around and is made out of 3 types of locations: hives, food nodes and lava. Hives are the most complex location because they not only create materials for the construction of other hives, but they also constantly support a fixed population of "ants" using an evolutionary algorithm in order to breed a new individual whenever one dies. Food nodes constantly offer food to be taken back to hives to generate material faster and, if they have enough materials in them, they turn into a hive. Lava is the most simple location since its only purpose is to be an obstacle that quickly damages any ant that walks over it.
  
  The inhabitants of this world are the aforementioned "ants", beings with a circular body and four extremities presenting eyes at their ends which are the only direct source of information about the surrounding world. Each ant has a brain which, based on its neural network, makes decisions about movement based on the information it reads at the pixels at which the eyes are located and its internal states (energy, hunger, health, age, etc.). It has no information about its purpose or reward system and the network is fixed (it does not learn over time).
  
  The general process, then, is that the initial population of ants has a completely random behavior which is then improved by evolution which is handled by each individual hive, the only information transmitted to the whole network of hives being the best individuals.
  
#### CONCLUSIONS:
  The first and most glaring observation is that since the only way for the ant brains to improve is by evolution, that is a very inefficient process that can easily regress by combining incompatible weights creating an inferior specimen from superior parents. Even so, a general behavior still emerges and the average fitness increases over time, even with the occasional drops.
  
  The second lies within their ability to sense the environment. Since an ant that manages to avoid lava is one that, generally, lives longer and is able to perform its duty better (even by random chance), those that know how to are going to have an immense advantage. Thus, they need to develop this skill and, since the only way of preventing collision is by seeing the lava ahead of time and the eyes are fixed points, after only a relatively small number of generations most ants will develop a style of locomotion that integrates constant spinning since it is the only way for them to actually take in the surrounding environment.
  
  The third can only be observed after a larger number of generations, and that is that even without a way to separate ants that are closer to achieving the goal (not just those that have already done so), a general pattern of movement does emerge. That pattern is similar to a vortex since each ant develops a circular pattern of movement, that being the only way of randomly hitting hives and food nodes in alternating order. The random part of that statement is essential since, again, the ants have no knowledge of their purpose so, by definition, the only way to perform that function is by random chance (or an extremely complex behavior I have not been able to generate in this simulation).
  
  
#### NOTES:
  Since the whole purpose of the project was individual study, once I had reached the point where I felt like I had learned everything I wanted from it I left it in a half-finished state, without any fancy functionalities.
  
  Some of those might be: better display, adjustable variables from the app itself, savestates, etc.
