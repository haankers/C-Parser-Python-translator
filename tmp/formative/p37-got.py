def main():
	x=0
	y=1
	z=(y or (x and x))
	return z

# Boilerplat
if __name__ == "__main__":
    import sys
    ret=main()
    sys.exit(ret)