import environment
import math, random

class FwdMovingAgent():
	
	def __init__(self, environment):
		self.environment = environment
		self.qvalues = [0] * len(self.environment.actions) 
		self.learning_rate = 0.8
		self.discount_factor = 0.5
		self.exploring_rate = 0.2
		self.total_reward = 0
									
	def get_Best_Action(self):
		possible_actions = self.environment.get_Possible_Actions()
		if(random.random()<self.exploring_rate):
			return random.choice(possible_actions)
		best = []
		max = -math.inf;
		for action in possible_actions:
			q = self.qvalues[action]
			if(q>max):
				max = q
				best = [action]
			elif(q==max):
				best.append(action)
		return random.choice(best)
			
	def do_Action(self):
		prev_state = self.environment.state
		action = self.get_Best_Action()
		self.environment.state = self.environment.get_resulting_State(action)
		reward = self.environment.get_Reward(action)
		self.total_reward = self.total_reward + reward
		self.update_Qvalues(prev_state, action, reward)		
		if(self.environment.isTerminal_State()):
			self.reset()
			return True
		return False
				
	def reset(self):
		print("Reward Accumulated:",self.total_reward)
		self.total_reward = 0
		self.exploring_rate = self.exploring_rate/2
						
	def update_Qvalues(self, state, action, reward):
		old_qvalue = self.qvalues[action]
		if(self.environment.isTerminal_State):	
			optimal_future_qvalue = 10
		else:
			nextActions = self.environment.get_Possible_Actions()
			optimal_future_qvalue = max([self.qValues[nextAction] for nextAction in nextActions])
		new_qvalue = old_qvalue + self.learning_rate * (reward + self.discount_factor * optimal_future_qvalue - old_qvalue)
		self.qvalues[action] = new_qvalue
		return