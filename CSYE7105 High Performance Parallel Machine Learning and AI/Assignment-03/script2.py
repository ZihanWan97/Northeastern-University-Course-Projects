# Find all numbers of kapreka within 10000 (four digits)
print("this is script2")

for i in range(1000, 10000):
    a = int(str(i)[:2])
    b = int(str(i)[2:])
    if (a + b) ** 2 == i:
        print(i)