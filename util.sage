#!/usr/bin/env sage


#------------------------------------------------#

#def mygcd(a,b):
#	if a == 0: return b
#	if b == 0: return a
#	if a < 0: a = -a
#	if b < 0: b = -b
#	if(b < a):
#		c = a
#		a = b
#		b = c
#	r = b%a
#	while r != 0:
#		b = a
#		a = r
#		r = b%a
#	return a


#def mylcm(a,b):
#	return a*b/mygcd(a,b)

#------------------------------------------------#

def exp(b,e):
	if e == 0: return 1
	t = exp(b,e>>1)^2
	if e & 1: t = t*b
	return t

#------------------------------------------------#

def exp_loop(b,e):
	p = b
	t = 1
	while e > 0 :
		if e&1 : t = t*p
		e = e>>1
		p = p*p
	return t

#------------------------------------------------#

def exp_mod_loop(b,e,n):
	p = b
	t = 1
	while e > 0 :
		if e&1 : t = (t*p)%n
		e = e>>1
		p = (p*p)%n
	return t%n

#------------------------------------------------#

#def isPrime(n):
#	list = []
#	for i in range (2,n+1):
#		if i*i > n:
#			return true
#		for j in list:
#			if n%j == 0:
#				return false
#			if j*j > i:
#				break
#			if i%j == 0:
#				continue
#		if n%i == 0:
#			return false
#		list.append(i)
#	return false


#------------------------------------------------#

def genprime(b):
	return genprime_range(1,b)

#------------------------------------------------#

def genprime_range(a,b):
	if a < 1: a = 1
	list = []
	p = next_prime(a-1)
	while p <= b:
		list.append(p)
		p = next_prime(p)
	return list

#------------------------------------------------#

#def genprime(b):
#	list = []
#	for i in range(2,b+1):
#		prime = true
#		for j in list:
#			if j*j > i:
#				break
#			if i % j == 0:
#				prime = false
#				break
#		if (prime):
#			list.append(i)
#	return list

#------------------------------------------------#

def divfirstnprime(n,l,list):

	plist = genprime(l)

	for i in plist:
		if i > n: break
		while n%i == 0:
			list.append(i)
			n = n/i
	return n,list

#------------------------------------------------#

def trialdivfrom(n,s,flist):

	p = next_prime(s-1)

	while n > 1 and p <= ZZ(n).sqrtrem()[0]:
		while n%p == 0:
			flist.append(p)
			n /= p
		p = next_prime(p)

	if n!=1:
		flist.append(n)

	return flist

#------------------------------------------------#

