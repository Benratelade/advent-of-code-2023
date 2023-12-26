```
  19, 13, 30 @ -2,  1, -2
  18, 19, 22 @ -1, -1, -2
  20, 25, 34 @ -2, -2, -4
  12, 31, 28 @ -1, -2, -1
  20, 19, 15 @  1, -5, -3
```

The problem tells us that: 

```
  Hailstone A: 19, 13, 30 @ -2, 1, -2
  Hailstone B: 18, 19, 22 @ -1, -1, -2
  Hailstones' paths will cross inside the test area (at x=14.333, y=15.333)
```

For the first hailstone: 
t+9: x:  1, y: 22
t+8: x:  3, y: 21
t+7: x:  5, y: 20
t+6: x:  7, y: 19
t+5: x:  9, y: 18
t+4: x: 11, y: 17
t+3: x: 13, y: 16
t+2: x: 15, y: 15
t+1: x: 17, y: 14

yb - ya / xb - xa
A(15,15), B(17,14)
(14 - 15) / (17 - 15) = -1/2
-1/2 * 13 + b = 16
b = 16 + 13/2 = 22.5
f(x) = -x/2 + 22.5

For the second hailstone:
t+5: x: 13, y: 14
t+4: x: 14, y: 15
t+3: x: 15, y: 16
t+2: x: 16, y: 17
t+1: x: 17, y: 18

A(16, 17), B(17, 18)
(18 - 17) / (17 - 16) = 1
15 + b = 16
b = 16 - 15 = 1
f(x) = x + 1

So we need to find out: 
for which value of x does
```
  y = x + 1 <=> y = ax + b
  y = -x/2 + 22.5 <=> y = cx + d

  ax + b = cx + d
  ax - cx = d - b
  (a - c)x = d - b
  x = (d - b) / (a - c)

  y = x + 1
  x + 1 = -x/2 + 22.5

  y = x + 1
  x + x/2 = 22.5 - 1 = 21.5
  3x/2 = 21.5
  x = 21.5 * 2 / 3 = 43 / 3 = 14.3333333333

  y = 43/3 + 1 = 15.333333333333
```

```
  starting_point: 20
  x_velocity: 2
  21: future
  19: past

  starting_point: 20
  x_velocity: -2
  21: past
  19: future

  starting_point: -20
  x_velocity: 2
  21: future
  19: future
  -21: past

  starting_point: -20
  x_velocity: -2
  21: past
  19: past
  -21: future
```