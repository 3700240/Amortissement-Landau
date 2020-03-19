import numpy as np
import matplotlib.pyplot as plt

def E(t,x):
    return x
    #return np.sin(x)*np.cos(t)

def dv(t,x):
	return -E(t,x)

def f(t,x):
	Z = np.zeros(2,float)
	Z[0] = x[1]
	Z[1] = dv(t,x[0])
	return Z


def Point_milieu(t,f,x0,v0):
    sizet = len(t)
    delta = t[1]-t[0]
    Z = np.zeros((sizet,2),float)
    pm = np.zeros((sizet,2),float)

    Z[0] = [x0,v0]

    for i in range(sizet-1):
        pm[i] = delta*f(t[i],Z[i])/2.0
        Z[i+1] = Z[i] + delta*f(t[i],Z[i]+pm[i])

    return Z


def Heun(t,f,x0,v0):
    sizet = len(t)
    delta = t[1]-t[0]
    Z = np.zeros((sizet,2),float)
    h = np.zeros((sizet,2),float)
    
    Z[0] = [x0,v0]
    
    for i in range(sizet-1):
        h[i] = Z[i] + delta*f(t[i],Z[i])
        Z[i+1] = Z[i] + delta/2. * (f(t[i],Z[i]) + f(t[i+1],h[i]))
    
    return Z 

def Symplectique(t,f,x0,v0): # Euler Symplectique
    sizet = len(t)
    delta = t[1]-t[0]
    Z = np.zeros((sizet,2),float)
    
    Z[0] = [x0,v0]
    
    for i in range(sizet-1):
        Z[i+1,0] = Z[i,0] + delta * Z[i,1]
        Z[i+1,1] = Z[i,1] + delta * f(t[i+1],Z[i+1,0])
       
    return Z
        
    


sizet = 1001
t0 = 0
tmax = 100
t = np.linspace(t0,tmax,sizet)
delta = t[1]-t[0]

plt.figure(1) # affichage Point Milieu

plt.subplot(2,1,1)
plt.plot(t, Point_milieu(t,f,0.,1.)[:,0])    
plt.xlabel('t')
plt.ylabel('X')
plt.title("Position par la methode du point milieu")
plt.legend()

plt.subplot(2,1,2)
plt.plot(t, Point_milieu(t,f,0.,1.)[:,1])  
plt.xlabel('t')
plt.ylabel('V')
plt.title("Vitesse par la methode du point milieu")
plt.legend()

plt.show(1)

plt.figure(2)

plt.plot(Point_milieu(t,f,0.,1.)[:,0],Point_milieu(t,f,0.,1.)[:,1])
plt.xlabel('X')
plt.ylabel('V')
plt.title("Position en fonction de la vitesse, point milieu")
plt.legend()

plt.show(2)

plt.figure(3) # affichage Heun

plt.subplot(2,1,1)
plt.plot(t, Heun(t,f,0.,1.)[:,0])    
plt.xlabel('t')
plt.ylabel('X')
plt.title("Position par la methode de Heun")
plt.legend()

plt.subplot(2,1,2)
plt.plot(t, Heun(t,f,0.,1.)[:,1])  
plt.xlabel('t')
plt.ylabel('V')
plt.title("Vitesse par la methode de Heun")
plt.legend()

plt.show(3)

plt.figure(4)

plt.plot(Heun(t,f,0.,1.)[:,0],Heun(t,f,0.,1.)[:,1])
plt.xlabel('X')
plt.ylabel('V')
plt.title("Position en fonction de la vitesse, Heun")
plt.legend()

plt.show(4)


plt.figure(5) # affichage Symplectique

plt.subplot(2,1,1)
plt.plot(t, Symplectique(t,dv,0.,1.)[:,0])    
plt.xlabel('t')
plt.ylabel('X')
plt.title("Position par la methode Symplectique")
plt.legend()

plt.subplot(2,1,2)
plt.plot(t, Symplectique(t,dv,0.,1.)[:,1])  
plt.xlabel('t')
plt.ylabel('V')
plt.title("Vitesse par la methode Symplectique")
plt.legend()

plt.show(5)

plt.figure(6)

plt.plot(Symplectique(t,dv,0.,1.)[:,0],Symplectique(t,dv,0.,1.)[:,1])
plt.xlabel('X')
plt.ylabel('V')
plt.title("Position en fonction de la vitesse, Euler Symplectique")
plt.legend()

plt.show(6)