#!/usr/bin/env sage

load "util.sage"

pretrial = 0
pminus1  = 0
postrial = 0

def pm1_aB(n,a,B):
	l = []
	s = 2

	for i in range (2,B):
		s = lcm(s,i)

#	d = gcd(a^s-1,n)
	d = gcd(exp_mod_loop(a,s,n)-1,n)

	if d == 1:
		d = n
	return [d,n/d]


def pm1_a(n,a):
	B = RR(n^(1/6)).ceiling()		###
	return pm1_aB(n,a,B)


def pm1_B(n,B):
	return pm1_aB(n,2,B)


def chgB_chga(n,l,flist):

	rlst = []
	a = 2
	B1 = RR(n^(1/6)).ceil()
	B2 = RR(n^(1/7)).floor()
	maxa = a + 10

	B = B1
	while n > 1 and (B > B2 or (maxa-a) > 0):
		if ZZ(n).is_prime():
			flist.append(n)
			if len(rlst) > 0:
				n = rlst.pop()
				continue
			else:
				return flist

		split = pm1_aB(n,a,B)
#		print split[0],split[1],a,B
		if split[1] != 1:
			a = 2
			B = B1
			rlst.append(split[1])
			n = split[0]
		elif B > B2:
			B -= 1
		else:
			a += 1
			B = B1
			

	global postrial
	postrial += 1
#	print " >> ended with using trial division <<"
	return trialdivfrom(n,l+1,flist)

#	flist.append(n)
#	return flist



#def chga_chgB():
#def chgB_onea():
#def chgB_twoa():
#def twoa_chgB():


def pm1_fac(n,l):
	flist = []
	n,flist = divfirstnprime(n,l,flist)
	global pretrial
	pretrial += 1

	if n == 1:
		return flist
	elif ZZ(n).is_prime():
		flist.append(n)
		return flist

	global pminus1
	pminus1 += 1
	return chgB_chga(n,l,flist)


	
#	rlst = []
#	a = 2
#	B = RR(n^(1/7)).ceil()			# <<-----------------------------------------------
#
#	while n != 1 and (not ZZ(n).is_prime()):
#		split = pm1_aB(n,a,B)
#		if split[1] != 1:
#			a = 2
#			rlst.append(split[1])
#			n = split[0]
#			if ZZ(n).is_prime():
#				flist.append(n)
#				if len(rlst) > 0:
#					n = rlst.pop()
#				else:
#					return flist
#		else:
#			a += 1
#
#	flist.append(n)
#	return flist





#for i in range (20):
#	n = randrange(10^8)+1
#	print n
#	print pm1_fac(n,100)
#	print n.factor()
#	print 


for i in range (100):
	n = randrange(10^50)+1
	pm1_fac(n,100)

o = open('result50.txt','w')
o.write(str(pretrial-pminus1) + " , " + str(pminus1-postrial) + " , " + str(postrial))
o.close()

#print pretrial-pminus1,pminus1-postrial,postrial












