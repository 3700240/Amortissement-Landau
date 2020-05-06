import numpy as np
import matplotlib.pyplot as plt

#############
# CONSTANTES#
#############


def E(t,x):
	return x

def dv(t,x):
	return -E(t,x)

def rk4(t,f, x0, v0):
	# t : timespan
	# f : fonction f(t,x) du problème de cauchy
	# x0 : conditions initiales
	sizet = len(t)
	x = np.empty(sizet, dtype=float)
	v = np.empty(sizet, dtype=float)

	x[0] = x0
	v[0] = v0

	print("début for")
	for i in range(sizet-1):
		print(i)
		h = t[i+1]-t[i]
		k1 = f(t[i],x[i])
		k2 = f(t[i]+h/2, x[i]+((h/2)*v[i]))
		k3 = f(t[i]+h/2, x[i]+((h/2)*v[i])+  ((h**2/4)*k1))
		k4 = f(t[i]+h, x[i]+ h*v[i]+  ((h**2/2)*k2))

		x[i+1] = x[i] + h*v[i] + (h**2/6)*(k1+k2+k3)
		v[i+1] = v[i] + (h/6)*(k1+2*k2+2*k3+k4)

	return x,v



if __name__ == '__main__':

	sizet = 1001
	t0 = 0
	tmax = 100
	t = np.linspace(t0,tmax,sizet)
	delta = t[1]-t[0]

	print(sizet)
	print(t)
	print(delta)

	x, v = rk4(t,dv, 0., 1.)
	plt.figure(1) # choose figure i to be the current figure (create it if not already existing)
	plt.plot(t,x)
	plt.plot(t,np.sin(t))


	plt.figure(2)
	plt.plot(t,v)
	plt.plot(t,np.cos(t))

	plt.show()
	print("Fin du programme")

	print(E,2)