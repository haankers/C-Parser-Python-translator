def f(a,b,c,d):
	if a :
		a=1
		if b :
			a=2
			if c :
				a=3
				if d :
					a=4
					return a
				else :
					a=5
					return a

			else :
				a=6
				return a

		else :
			a=7
			return a

	else :
		a=8
		return a


def main():
	return f(1,2,3,4)

# Boilerplat
if __name__ == "__main__":
    import sys
    ret=main()
    sys.exit(ret)