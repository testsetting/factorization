#!/usr/bin/env sage

load "util.sage"

#-----------------------------------------------#
####            GLOBAL VARIABLES             ####
#-----------------------------------------------#

a = 1
base_ext   = []
base_ext_t = []
#base_ext   = [base[0],base[1],1,base[0]*base[1]]
#base_ext_t = [base[0],base[1],1,base[0]*base[1]*2*d]


numpre = 0	# first trial division
numecm = 0	# use ecm
numpos = 0	# finish with another trial division

numtry = 0	# number of curves tried

#-----------------------------------------------#
############# END GLOBAL VARIABLES ##############
#-----------------------------------------------#


#-----------------------------------------------#
####               CURVE SETUP               ####
#-----------------------------------------------#
alist = [-1,1,1]
dlist = []
blist = []

# a * x^2 + y^2 = 1 + d * x^2 * y^2
#  x  = X/Z
#  y  = Y/Z
# x*y = T/Z

#-----------------------------------------------#
# From starfish on Strike
tdlist = []
tblist = []

# winner for 22-bit primes
#a = -1
tdlist.append(6517/196608)
tblist.append([	[336/527,80/67]])

# runner-up for 22-bit primes
#a = -1
tdlist.append(-13312/18225)
tblist.append([	[825/2752,1521/1504]])

dlist.append(tdlist)
blist.append(tblist)
#-----------------------------------------------#


#-----------------------------------------------#
# List from eecm.cr.yp.to/goodcurves
# all have a = 1
#a = 1

# Torsion group Z/12Z ----------#
tdlist = []
tblist = []

tdlist.append(-24167/25)
tblist.append([	[5/23,-1/7]])

tdlist.append(-895973/27)
tblist.append([	[81/5699, -901/2501],
		[117/133, -1/337]])

tdlist.append(-13391879/121)
tblist.append([	[11/6739, -29/33],
		[11/589, -17/107],
		[11/349, -13/137],
		[13/137, -11/349],
		[17/107, -11/589],
		[29/33, -11/6739],
		[451/549, -7/3355],
		[121/122, -3/7747]])

tdlist.append(-5883882125/243)
tblist.append([	[729/34529, -85/8833],
		[27/82445, -29/55],
		[29/55, -27/82445]])

tdlist.append(1375/1024)
tblist.append([	[56/65, -44/5],
		[8/17, -20/19],
		[128/115, -3/5]])

tdlist.append(81289/15625)
tblist.append([	[5/4, -25/89]])

tdlist.append(4913/18225)
tblist.append([	[285/293, -153/569],
		[35/17, -81/17],
		[45/19, -3]])

tdlist.append(-268279/35721)
tblist.append([	[11/61, -567/643],
		[651/5771, -468/493],
		[567/643, -11/61]])

tdlist.append(50531/46656)
tblist.append([	[36/325, -1938/1937],
		[352/377, -729/481],
		[138/107, -252/277],
		[252/277, -138/107],
		[1938/1937, -36/325]])

tdlist.append(-12907375/88209)
tblist.append([	[33/545, -153/190],
		[891/3341, -115/403],
		[153/190, -33/545]])

dlist.append(tdlist)
blist.append(tblist)



# Torsion group Z/2Z x Z/8Z ----------#
tdlist = []
tblist = []

tdlist.append(25921/83521)
tblist.append([	[289/299, 7/23],
		[17/19, 17/33],
		[13/7, 289/49],
		[323/161, 561/161]])

tdlist.append(1681/707281)
tblist.append([	[319/403, 551/901],
		[122/123, 841/6601]])

tdlist.append(2307361/2825761)
tblist.append([	[943/979, 1271/2329]])

tdlist.append(23804641/62742241)
tblist.append([	[7921/8979, 23/41],
		[623/103, 979/589],
		[89/489, 1513/1529],
		[1691/4141, 5607/5945]])

tdlist.append(418079809/442050625)
tblist.append([	[125/91, 841/791],
		[1015/437, 1595/1541],
		[2755/6223, 9715/9779]])

tdlist.append(44182609/1766100625)
tblist.append([	[8405/15801, 215/253],
		[1025/158, 697/25],
		[6478/6647, 25625/112999]])

tdlist.append(779135569/1766100625)
tblist.append([	[1025/1032, 41/265]])

tdlist.append(857376961/3373402561)
tblist.append([	[723/118, 6989/3379]])

tdlist.append(1003559041/6975757441)
tblist.append([	[4913/377, 51/19],
		[4913/8611, 731/869]])

tdlist.append(3139697089/8653650625)
tblist.append([	[305/851, 305/319],
		[3721/7771, 375/409]])

dlist.append(tdlist)
blist.append(tblist)
#------------------------------------------------#
################# END CURVE SETUP ################
#------------------------------------------------#



#----------------------------------------------------------#
# try different curves different base points
#for i in range (len(alist)):
#	a = alist[i]
#
#	for j in range (len(dlist[i])):
#		d = dlist[i][j]
#
#		for base in blist[i][j]:
#			x = base[0]
#			y = base[1]
#
#			lhs = a * x^2 + y^2
#			rhs = 1 + d * x^2 * y^2
#
#			print i, ":", lhs-rhs, lhs==rhs
#----------------------------------------------------------#




#----------------------------------------------------------#
####                  POINT ARITHMETIC                  ####
#----------------------------------------------------------#
def padd_twist_ed_min_one_base(P,n):
# 6M + 1*2 + 8add
	if P == None: return

	A = (P[1]-P[0])*(base_ext[1]-base_ext[0])
	B = (P[1]+P[0])*(base_ext[1]+base_ext[0])
	C = P[3]*base_ext_t[3]
	D = 2*P[2]
	E = B-A
	F = D-C
	G = D+C
	H = B+A

	try:
		X = (E*F)%n
		Y = (G*H)%n
		Z = (F*G)%n
	except:
		return

	return [X,Y,Z]


#----------------------------------------------------------#

def pdbl_twist_ed(P,n):
# 4S + 4M + 1*a + 1*2 + 6add
	if P == None: return

	A = P[0]^2
	B = P[1]^2
	C = 2*P[2]^2
	D = a*A
	E = (P[0]+P[1])^2 - A - B
	G = D+B
	F = G-C
	H = D-B

	try:
		X = (E*F)%n
		Y = (G*H)%n
		Z = (F*G)%n
		T = (E*H)%n
	except:
		return

	return [X,Y,Z,T]


#----------------------------------------------------------#


def padd_twist_ed_base(P,n):
	if P == None: return

	A = P[0]*base_ext[0]
	B = P[1]*base_ext[1]
	C = P[3]*base_ext_t[3]
	D = P[2]
	E = (P[0]+P[1])*(base_ext[0]+base_ext[1]) - A - B
	F = D-C
	G = D+C
	H = B-a*A

	try:
		X = (E*F)%n
		Y = (G*H)%n
		Z = (F*G)%n
	except:
		return

	return [X,Y,Z]


#----------------------------------------------------------#
################### END POINT ARITHMETIC ###################
#----------------------------------------------------------#


#----------------------------------------------------------#
####               SCALAR MULTIPLICATION                ####
#----------------------------------------------------------#
def smult_dblandadd(P,s,n):
	b = bin(s)
	R = P
	for i in range (2,len(b)):
		R = pdbl_twist_ed(R,n)
		if b[i] == 1:
#			R = padd_twist_ed_min_one_base(R)
			R = padd_twist_ed_base(R,n)
	return R


#----------------------------------------------------------#
####            Elliptic Curve Method (ECM)             ####
#----------------------------------------------------------#
def ecm(n):
	B = RR(n^(1/6)).ceiling()		###
	s = 2

	for i in range (2,B):
		s = lcm(s,i)


#-- select curve & base point --#

	global numtry
	numtry = 0

	for i in range (len(alist)):
		a_ = alist[i]

		for j in range (len(dlist[i])):
			d = dlist[i][j]

			for base in blist[i][j]:

				numtry += 1

				global a
				a = a_

				global base_ext
				global base_ext_t

				base_ext   = [base[0],base[1],1,base[0]*base[1]]
				base_ext_t = [base[0],base[1],1,base[0]*base[1]*2*d]


				P = smult_dblandadd(base_ext,s,n)

				if (P != None):
					r = gcd(P[0]%n,n)
					if r != 1:
						return [r,n/r]
				else:
					r = 1

	if r == 1:
		r = n
#		print "-----> fail <-----"
	return [r,n/r]



#----------------------------------------------------------#
####                   FACTORIZATION                    ####
#----------------------------------------------------------#
def ecm_fac(n,l):
	flist = []
	n,flist = divfirstnprime(n,l,flist)
	global numpre
	numpre += 1

	if ZZ(n).is_prime():
		flist.append(n)
		return flist

	B1 = RR(n^(1/7)).ceil()
	B2 = RR(n^(1/6)).ceil()
	B = B2

	rlst = []

	global numecm
	numecm += 1

	while n != 1 and B > B1:
		if ZZ(n).is_prime():
			flist.append(n)
			if len(rlst) > 0:
				n = rlst.pop()
				continue
			else:
				return flist

		split = ecm(n)
#		print "-->",split[0],split[1],B
		if split == None:
			B -= 1
		elif split[1] != 1:
			B = B2
			rlst.append(split[1])
			n = split[0]
		else:
#			print "try diff B"
			B -= 1


	global numpos
	numpos += 1
	return trialdivfrom(n,l+1,flist)
#----------------------------------------------------------#



##############
##   TEST   ##
##############

#for i in range (50):
#	numtry = 0
#	n = randrange(10^10)+1
#	print n
#	print ecm_fac(n,100)
#	print n.factor()
#	print numtry
#	print


for i in range (100):
	n = randrange(10^50)+1
	ecm_fac(n,100)

o = open('result50.txt','w')
o.write(str(numpre-numecm) + " , " + str(numecm-numpos) + " , " + str(numpos))
o.close()

#print numpre-numecm,numecm-numpos,numpos
