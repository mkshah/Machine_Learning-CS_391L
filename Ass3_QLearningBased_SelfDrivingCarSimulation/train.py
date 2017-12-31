from environment import Environment
from FwdMovingAgent import FwdMovingAgent
from TrafficSignalFollowingAgent import TrafficSignalFollowingAgent
from ObstacleAvoidingAgent import ObstacleAvoidingAgent
import pygame, sys
from pygame.locals import *
import random

if __name__ == '__main__':
	Road = Environment(2,20)
	#SDCar = FwdMovingAgent(Road)
	SDCar = ObstacleAvoidingAgent(Road)
	Episodes = 20
	
	pygame.init()
	size = width, height = 150, 250
	black = 0, 0, 0
	screen = pygame.display.set_mode(size)
	#screen.fill(black)
	background = pygame.image.load('background.bmp').convert()
	screen.blit(background, (0, 0))
	pothole = pygame.image.load('pothole.PNG').convert()
	car = pygame.image.load('car2.PNG').convert()
	red = pygame.image.load('redsignal.png').convert()
	green = pygame.image.load('greensignal.png').convert()
	
	for episode in range(Episodes):
		Road.reset()
		steps = 0
		reached_Terminal_State = False
		#cnt =random.randint(5,10)
		#cnt1= cnt
		while(reached_Terminal_State==False):
			reached_Terminal_State = SDCar.do_Action()
			steps = steps + 1
			#print(Road.state)
			#screen.fill(black)	
			#if(Road.shouldCarStop(Road.state) or cnt!=cnt1):
			#	cnt = cnt - 1
			#	print(Road.traffic_signal_state)
			#if(cnt==0):
			#	Road.traffic_signal_state = 0
			#	print(Road.traffic_signal_state)
			#	cnt=cnt1		
			screen.blit(background, (0, 0))
			screen.blit(pothole, (27+Road.obstacle_place[0]*25, 30+Road.obstacle_place[1]*11))
			screen.blit(car, (27+Road.state[0]*25, Road.state[1]*11))
			#if(Road.traffic_signal_state==1):
			#	screen.blit(red, (15, 35+Road.traffic_signal_place*11))
			#else:
			#	screen.blit(green, (15, 35+Road.traffic_signal_place*11))
			pygame.display.update()
			pygame.time.delay(100)
		print("Episode",episode,": Steps:",steps)
		print(SDCar.qvalues)