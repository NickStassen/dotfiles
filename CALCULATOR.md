# IPython Calculator

A scientific calculator, symbolic math engine, and plotter in one terminal: IPython with numpy, matplotlib, and sympy preloaded, plus unit shortcuts and automatic session logs.

- [Launching](#launching)
- [What's preloaded](#whats-preloaded)
- [Everyday math](#everyday-math)
- [Units](#units)
- [Algebra and calculus](#algebra-and-calculus)
- [Statistics and data](#statistics-and-data)
- [Plotting](#plotting)
- [Saving and recalling work](#saving-and-recalling-work)
- [Gotchas](#gotchas)
- [Customizing](#customizing)

## Launching

| How | What you get |
|-----|--------------|
| `Super+C` / `Meta+C` | New terminal with the calculator (GNOME / KDE Plasma; on KDE, active after your next login) |
| App menu → *IPython Calculator* | Same, from the launcher or KRunner on any desktop |
| `ipython` | Calculator in the current terminal |
| `calc <expr>` | One-shot answer from the shell, no quoting: `calc sqrt(2)*pi`, `calc (3+4)*5` |
| `isympy -I` | Pure symbolic session: every name is sympy, unknown names become symbols, `1/3` stays exact |

Exit with `Ctrl-D`. Startup takes about a second.

## What's preloaded

| Name | What |
|------|------|
| `np`, `plt`, `sp` | numpy, matplotlib.pyplot, sympy |
| `pi`, `e`, `inf` | constants |
| `sqrt` `cbrt` `exp` `log` `log10` `log2` | numpy functions, work on numbers and whole arrays |
| `sin` `cos` `tan` `arcsin` `arccos` `arctan` `arctan2` `hypot` | trig, **radians** |
| `degrees` `radians` | rad → deg, deg → rad |
| `km` `mm` `um` `nm` | length multipliers, base unit meters |
| `mrad` `urad` `deg` `arcmin` `arcsec` | angle multipliers, base unit radians |

Floats print plainly (`1.414`, not `np.float64(1.414)`), and plots open in live windows.

## Everyday math

```python
_ * 1.08                         # _ is the last result, __ the one before, _5 is Out[5]
(119 - 99)/99*100                # percent change -> 20.2
1000*(1 + 0.05/12)**(12*10)      # $1000 at 5%, compounded monthly, 10 years -> 1647.01
(5 - 2.0)/20e-3                  # LED resistor: (supply - Vf)/current -> 150 ohms
1/(1/220 + 1/330)                # resistors in parallel -> 132
2**200                           # integers never overflow
```

Number formats:

```python
0xff, 0b1010, hex(255), int('ff', 16)    # 255, 10, '0xff', 255
f"{1234567.891:,.2f}"                    # '1,234,567.89'
f"{0.000123:.2e}"                        # '1.23e-04'
%precision 3                             # show floats to 3 places (math unchanged); %precision to reset
```

Exact values:

```python
from fractions import Fraction as F; F(1,3) + F(1,6)    # 1/2
sp.nsimplify(0.75)                                      # 3/4
sp.N(sp.pi, 30)                                         # 3.14159265358979323846264338328
```

Dates and times:

```python
from datetime import datetime as dt, timedelta
(dt(2026, 12, 25) - dt(2026, 10, 7)).days           # 79
dt(2026, 10, 7, 9, 30) + timedelta(hours=7, minutes=45)   # 17:15
```

## Units

Values are stored in meters and radians. **Multiply** by a unit to enter a value, **divide** by a unit to read it back. Meters need no suffix.

```python
30*deg                                   # 0.5236 rad
sin(30*deg)                              # 0.49999999999999994, i.e. 0.5 (float rounding)
2*arctan(6.4*mm/2/(16*mm))/deg           # field of view: 6.4 mm sensor, 16 mm lens -> 22.6 deg
3.45*um/(16*mm)/urad                     # angle per pixel: 3.45 um pixels, 16 mm lens -> 216 urad
1.8/(10*216*urad)                        # a 1.8 m object spanning 10 such pixels is 833 m away
2*mm + 100*1*mrad                        # 2 mm laser, 1 mrad divergence, 100 m away -> 0.102 m spot
2*arctan(3474/2/384400)/deg              # the Moon's angular size -> 0.518 deg
1.22*550*nm/(200*mm)/arcsec              # diffraction limit of a 200 mm telescope -> 0.69 arcsec
```

Wrap repeated formulas in a function (`%edit` opens an editor for longer ones):

```python
def fov(sensor, focal): return 2*arctan(sensor/2/focal)
fov(6.4*mm, 16*mm)/deg
fov(6.4*mm, np.array([8, 16, 35, 50])*mm)/deg    # whole lens lineup at once
```

## Algebra and calculus

Make symbols first, then use `sp.` functions on them.

```python
x = sp.symbols('x')
sp.solve(x**2 - 5*x + 6, x)                # [2, 3]
sp.solve(sp.Eq(3*x + 2, 11), x)            # [3]
sp.nsolve(sp.cos(x) - x, x, 1)             # numeric root near 1 -> 0.739
sp.diff(x**3*sp.exp(x), x)                 # x**3*exp(x) + 3*x**2*exp(x)
sp.integrate(x*sp.sin(x), x)               # -x*cos(x) + sin(x)
sp.integrate(sp.exp(-x), (x, 0, sp.oo))    # 1
sp.Integral(sp.exp(-x**2), (x, 0, 1)).evalf()   # 0.7468 (no closed form needed)
sp.limit(sp.sin(x)/x, x, 0)                # 1
sp.series(sp.tan(x), x, 0, 6)              # x + x**3/3 + 2*x**5/15 + O(x**6)
sp.simplify(sp.sin(x)**2 + sp.cos(x)**2)   # 1
(x**2 + 1).subs(x, 2)                      # plug in a value -> 5
```

Linear algebra:

```python
sp.Matrix([[1, 2], [3, 4]]).det()          # -2 (exact)
np.linalg.solve([[2, 1], [1, 3]], [3, 5])  # 2a + b = 3, a + 3b = 5 -> [0.8, 1.4]
A = np.array([[1, 2], [3, 4]])
np.linalg.inv(A), np.linalg.eigvals(A)     # inverse, eigenvalues
```

## Statistics and data

```python
data = [3.1, 2.9, 3.4, 3.0, 3.2]
np.mean(data), np.median(data), np.std(data, ddof=1)    # 3.12, 3.1, 0.192 (sample std)
min(data), max(data), np.percentile(data, 90)
```

Compare options, e.g. price per TB across drives:

```python
price = np.array([79, 119, 199]); tb = np.array([1, 2, 4])
price/tb                                          # [79, 59.5, 49.75] $/TB
sorted(zip(price/tb, ['1TB', '2TB', '4TB']))      # cheapest per TB first
```

Fit a line to measurements:

```python
np.polyfit([0, 1, 2, 3], [1.1, 2.9, 5.2, 6.9], 1)   # slope 1.97, intercept 1.07
```

## Plotting

Plots open in their own window and update as you type; `plt.show()` isn't needed.

```python
plt.plot(xs := np.linspace(0, 10, 500), sin(xs))         # quick function plot
plt.plot(xs, cos(xs), label='cos'); plt.legend(); plt.grid(True)
plt.figure()                                             # start a new window instead of drawing on the last one
```

Straight from sympy expressions (`x, y = sp.symbols('x y')`):

```python
sp.plot(sp.sin(x)/x, (x, -20, 20))
sp.plot_implicit(sp.Eq(x**2/4 + y**2, 1))                  # ellipse
sp.plot_parametric(sp.cos(3*x), sp.sin(2*x), (x, 0, 2*pi)) # Lissajous curve
sp.plotting.plot3d(sp.sin(x*y), (x, -3, 3), (y, -3, 3))    # surface
```

Turn a sympy result into a fast numpy function:

```python
f = sp.lambdify(x, sp.integrate(x*sp.sin(x), x))
plt.plot(xs, f(xs))
```

Numeric calculus on sampled data: `np.gradient(y, xs)` (derivative), `np.trapezoid(y, xs)` (area).

Windows: `plt.close('all')` closes every plot. To bring back a figure you closed: `plt.figure(fig); plt.show()`.

## Saving and recalling work

Every session is logged automatically, inputs and outputs, to `~/ipython-logs/<date>_<time>.py`.

| Command | Does |
|---------|------|
| `%run -i ~/ipython-logs/<file>.py` | Replay an old session, restoring its variables |
| `%history -g fov` | Search every past session |
| `%history -n 1-10` | Show this session's lines |
| `%recall 5` | Put line 5 back at the prompt to edit |
| `%save work.py 1-12` | Save lines to a file |
| `%notebook work.ipynb` | Export the session as a Jupyter notebook |
| `%store fov` / `%store -r` | Keep a variable or function across sessions / load it back |
| `%who`, `%whos` | List your variables |

Typing the start of a line then `↑` cycles through matching history; `Ctrl-R` searches; grey suggestions accept with `→`.

Prune old logs: `find ~/ipython-logs -mtime +90 -delete`.

## Gotchas

- `^` is XOR (`2^10` is `8`). Powers are `**`.
- Trig takes radians: `sin(30*deg)` or `sin(radians(30))`, not `sin(30)`.
- Use `sp.sin`, `sp.exp`, ... on sympy symbols. The bare `sin` is numpy's and fails on symbols.
- Assigning `e = 5` or `x = ...` hides the preloaded name for that session.
- Over SSH (no display), plots don't open windows; save them with `plt.savefig('plot.png')`.

## Customizing

| File | Holds |
|------|-------|
| `ipython/startup/00-imports.ipy` | Imports, units, session logging, plot backend |
| `ipython/ipython_config.py` | IPython settings (banner, exit confirmation) |
| `zshrc` | `calc` helper, `ipython` alias |
| `install.sh` | Symlinks, app-menu entry, and the `Super+C`/`Meta+C` shortcut |
| `ipython/ipython-calc.desktop` | The app-menu entry |

Add your own constants or functions to the startup file; any extra `*.py`/`*.ipy` file in `~/.ipython/profile_default/startup/` runs too, in name order.
