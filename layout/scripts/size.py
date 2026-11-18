import re,sys
s=open(sys.argv[1]).read();xs=[];ys=[]
for m in re.finditer(r'^rect (-?\d+) (-?\d+) (-?\d+) (-?\d+)',s,re.M):
    a=list(map(int,m.groups()));xs+=a[::2];ys+=a[1::2]
w,h=(max(xs)-min(xs))/200,(max(ys)-min(ys))/200
print(f"{sys.argv[1].split('/')[-1]}: {w:.1f} x {h:.1f} um = {w*h:.0f} um2")
