# Output the first 20 terms of the Fibonacci series
print("this is script3")

def a(x):
    if x == 1 or x == 2:
        return 1
    else:
        return a(x - 1) + a(x - 2)

for i in range(1, 21):
    print(a(i))