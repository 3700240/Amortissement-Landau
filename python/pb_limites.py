import numpy as np
import matplotlib.pyplot as plt
from scipy.linalg import solve

def h(x,t): # E'(x,t)
    return np.sin(x)


def matrice(sizet):
    A = -2*np.eye(sizet-2,sizet-2)
    for i in range (sizet -3):
        A[i,i+1] = 1
        A[i+1,i] = 1
    return A


def vecteur_H(sizet):
    H = np.zeros((sizet-2,1),float)
    for i in range(sizet-2):
        H[i,0] = h(x[i+1],t) 
    return H  


def factorisation_LU(A):
    sizet = len(A)
    L = np.eye(sizet,sizet)
    for k in range(sizet-1):
        for i in range (k+1,sizet):
            L[i,k]=A[i,k]/A[k,k]
            A[i,:]=A[i,:]-L[i,k]*A[k,:]
    return L,A 


def descente(L,b):
    sizet=len(L)
    Y = np.zeros(sizet,float)
    Y[0]=b[0]
    for i in range(1,sizet):
        Y[i]=b[i]
        for j in range(0,i):
            Y[i]=Y[i]-L[i,j]*Y[j]
    return Y


def remontee(U,Y):
    n=len(U)
    X = np.zeros(n,float)
    X[n-1]=float(Y[n-1])/float(U[n-1,n-1])
    for i in range(n-2,-1,-1):
        X[i]=Y[i]/U[i][i]
        for j in range(i+1,n):
            X[i]=X[i]-U[i][j]*X[j]/U[i][i]
    return X


def champ_E(phi,x):
    sizet = len(phi)
    delta = float(x[1]-x[0])
    E = np.zeros(sizet,float)
    E[0] = phi[1]/(2*delta)
    E[sizet-1] = -phi[sizet-2]/(2*delta)
    for i in range(1,sizet-1):
        E[i] = (phi[i+1] - phi[i-1])/(2*delta)
    return E




sizet = 1000
x0 = 0
L = 20
t0 = 0
tmax = 100

t = np.linspace(t0,tmax,sizet)
x = np.linspace(x0,L,sizet)

A = matrice(sizet)/(x[1]-x[0])**2
H = vecteur_H(sizet)

L,U = factorisation_LU(A)
Y = descente(L,H)
phi = remontee(U,Y)

E = champ_E(phi,x)


plt.figure(figsize=(10,15)) # affichage champ

plt.subplot(3,1,1)
plt.plot(x[1:sizet-1], E)    
plt.xlabel('x')
plt.ylabel('E')
plt.title("Champ en fonction de la position")
plt.legend()

plt.subplot(3,1,2)
plt.plot(x[1:sizet-1], phi)  
plt.xlabel('x')
plt.ylabel('phi')
plt.title("Primitive de E")
plt.legend()

plt.subplot(3,1,3)
plt.plot(x[1:sizet-1], H)  
plt.xlabel('x')
plt.ylabel('h(x)')
plt.title("derivee de E")
plt.legend()

plt.show()                        
