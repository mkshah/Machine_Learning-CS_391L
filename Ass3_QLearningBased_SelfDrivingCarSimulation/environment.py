import random
class Environment():
	
	def __init__(self, width, height):
		self.width = width
		self.height = height
		self.state = [0,0]
		self.actions = [0,1,2,3]
		self.traffic_signal_state = 1
		self.traffic_signal_place = random.randint(self.height/4,3*self.height/4)
		self.obstacle_place = [random.randint(0,1), random.randint(2*self.height/10,7*self.height/10)]
	
	def shouldCarStop(self, state):
		dis = self.traffic_signal_place - state[1]
		if(self.traffic_signal_state==1 and dis==2):
			return True
		return False
	
	def isObstacleNearby(self, state):
		dis1 = self.obstacle_place[0] - state[0]
		dis2 = self.obstacle_place[1] - state[1]
		if(dis1==0 and dis2==2):
			return True
		return False
	
	def changeTrafficSignal(self):
		self.traffic_signal_state = (self.traffic_signal_state + 1)%2
		
	def reset(self):
		self.state = [0,0]
		self.traffic_signal_state = 1
		self.traffic_signal_place = random.randint(self.height/4,3*self.height/4)
		self.obstacle_place = [random.randint(0,1), random.randint(2*self.height/10,7*self.height/10)]
					
	def isTerminal_State(self):
		if(self.state==[0,self.height-1]):
			return True
		return False
	
	def get_Possible_Actions(self):
		if(self.isTerminal_State()):
			return []
		w = self.state[0]
		h = self.state[1]
		possible_Actions = []
		possible_Actions.append(3)
		if(h+1<self.height):
			possible_Actions.append(0)
		if(w+1<self.width):
			possible_Actions.append(2)
		if(w-1>=0):
			possible_Actions.append(1)	
		return possible_Actions
	
	def get_Reward(self, action):
		if(self.isTerminal_State()):
			return 10;
		elif(action==0):
			return 1;
		else:
			return -5; 
	
	def get_Reward_TrafficSignalFollowingAgent(self, state, action):
		if(self.shouldCarStop(state)==True and action==3):
			return 5;
		elif(self.shouldCarStop(state)==True and action==0):
			return -5;
		elif(self.shouldCarStop(state)==False and action==3):
			return -2;
		elif(self.shouldCarStop(state)==False and action==0):
			return 2;
		else:
			return -5;
		
	def get_Reward_ObstacleAvoidingAgent(self, state, action):
		if(self.isObstacleNearby(state)==True and (action==0 or action==3)):
			return -3;		
		elif(self.isObstacleNearby(state)==True and (action==1 or action==2)):
			return 5;
		elif(action==0):
			return 1;
		else:
			return -5;

		
	def get_resulting_State(self, action):
		w = self.state[0]
		h = self.state[1]
		if(action==0):
			self.state = [w, h+1]
		elif(action==1):
			self.state = [w-1, h]
		elif(action==2):
			self.state = [w+1, h]
		return self.state
		