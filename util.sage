#!/usr/bin/env sage

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

def exp(b,e):
	if e == 0: return 1
	t = exp(b,e>>1)^2
	if e & 1: t = t*b
	return t

def exp_loop(b,e):
	p = b
	t = 1
	while e > 0 :
		if e&1 : t = t*p
		e = e>>1
		p = p*p
	return t

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


def genprime(b):
	list = []
	for i in range (1,b+1):
		if ZZ(i).is_prime():
			list.append(i)
	return list

def genprime_ab0(a,b):
	if a < 1: a = 1
	list = []
	for i in range (a,b+1):
		if ZZ(i).is_prime():
			list.append(i)
	return list





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


def divfirstnprime(n,l,list):
	plist = genprime(l)
	for i in plist:
		while n%i == 0:
			list.append(i)
			n = n/i
	return n,list


def trialdivfrom(n,s,flist):

	while n%2 == 0:
		flist.append(2)
		n = n/2

	if s < 2 :
		s = 3
	elif s%2 == 0 :
		p = s+1
	else :
		p = s

	while n > 1 and p <= ZZ(n).sqrtrem()[0]:
		if p.is_prime():
			while n%p == 0:
				flist.append(p)
				n = n/p
		p = p+2

	if n != 1:
		flist.append(n)
		n = n/n

	return flist

#
#p = 12345
#
#list = []
#n,l = trialdiv(p,100,list)
#print p,n,l
#
#list = []
#n,l = trialdiv(p,1000,list)
#print p,n,l
#
#list = []
#n,l = trialdiv(p,10000,list)
#print p,n,l


#for i in range (10):
#	b = randrange(100)
#	e = randrange(100)
#	print exp(b,e)
#	print exp_loop(b,e)
#	print b^e
#	print


