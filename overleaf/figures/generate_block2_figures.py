"""Optional regeneration; PDFs are included, so Overleaf needs no Python."""
from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from scipy import stats
D=Path(__file__).resolve().parent
plt.rcParams.update({'font.size':13,'axes.spines.top':False,'axes.spines.right':False,'savefig.bbox':'tight','axes.labelcolor':'#123452','text.color':'#123452','axes.edgecolor':'#123452','xtick.color':'#123452','ytick.color':'#123452'})
navy='#123452';orange='#c26322';rng=np.random.default_rng(20261104)
pop=rng.lognormal(4.2,.8,1000);mu=pop.mean();priority=pop[pop>np.quantile(pop,.75)]
fig,ax=plt.subplots(1,3,figsize=(12,3.6))
ax[0].hist(pop,25,color=orange);ax[0].set(title='Individual filings',xlabel='Declared amount (thousand EUR)',ylabel='Frequency')
for n,col in [(10,orange),(100,navy)]:
 means=[rng.choice(pop,n,replace=False).mean()for _ in range(600)]
 ax[1].hist(means,22,alpha=.6,color=col,label=f'n = {n}')
ax[1].axvline(mu,color='black',ls='--');ax[1].set(title='Random sample means',xlabel='Mean declared amount');ax[1].legend(frameon=False)
for pool,col,label in [(pop,navy,'All filings'),(priority,orange,'Priority only')]:
 means=[rng.choice(pool,100,replace=False).mean()for _ in range(600)]
 ax[2].hist(means,20,alpha=.65,color=col,label=label)
ax[2].axvline(mu,color='black',ls='--');ax[2].set(title='Precision and selection',xlabel='Mean declared amount');ax[2].legend(frameon=False,fontsize=10)
fig.tight_layout();fig.savefig(D/'sampling_block2.pdf');plt.close(fig)
fig,ax=plt.subplots(figsize=(9,3.8));c=stats.t.ppf(.975,24);covered=0
for i in range(40):
 a=rng.normal(10,2,25);m=a.mean();e=c*stats.sem(a);ok=m-e<=10<=m+e;covered+=ok
 ax.plot([m-e,m+e],[i,i],color=navy if ok else orange,lw=1.5);ax.plot(m,i,'o'if ok else 'x',color=navy if ok else orange,ms=3)
ax.axvline(10,color='black',ls='--');ax.set(xlabel='Population mean processing time (days)',ylabel='Repeated sample',title=f'40 intervals: {covered} contain the fixed mean');fig.tight_layout();fig.savefig(D/'coverage_block2.pdf');plt.close(fig)
x=np.linspace(-4,4,500);fig,ax=plt.subplots(figsize=(8,3.5));ax.plot(x,stats.norm.pdf(x),color=navy,label='Standard normal');ax.plot(x,stats.t.pdf(x,4),color=orange,label='t, df = 4');ax.plot(x,stats.t.pdf(x,24),color='#806953',ls='--',label='t, df = 24');ax.set(xlabel='Standardised statistic',ylabel='Density');ax.legend(frameon=False);fig.tight_layout();fig.savefig(D/'t_block2.pdf');plt.close(fig)
groups=[[4,6,5,7,3,5],[8,10,7,9,11,9],[12,14,11,13,15,13]];fig,ax=plt.subplots(figsize=(9,3.6))
for i,g in enumerate(groups):
 ax.scatter(g,i+np.array([-.04,.04]*3),color=orange);ax.plot([np.mean(g)]*2,[i-.25,i+.25],color=navy,lw=3)
ax.set(yticks=[0,1,2],yticklabels=['A','B','C'],xlabel='Processing days',ylabel='Procedure',xlim=(1,17));fig.tight_layout();fig.savefig(D/'groups_block2.pdf');plt.close(fig)
x=np.arange(1,16);y=5+1.8*x+np.array([2,-3,1,0,4,-2,1,-4,2,0,3,-1,-3,2,1]);fig,ax=plt.subplots(1,3,figsize=(12,3.6))
for a,xx,yy,t in [(ax[0],x,y,'Base workload'),(ax[1],np.r_[x,25],np.r_[y,5],'One influential case'),(ax[2],np.arange(-3,4),np.arange(-3,4)**2,'Nonlinear dependence')]:
 reg=stats.linregress(xx,yy);a.scatter(xx,yy,color=orange);a.plot(xx,reg.intercept+reg.slope*xx,color=navy);a.set(title=t+f'\nr = {reg.rvalue:.3f}',xlabel='Documents'if a!=ax[2]else'X',ylabel='Review minutes'if a!=ax[2]else'Y = X²')
fig.tight_layout();fig.savefig(D/'scatter_block2.pdf');plt.close(fig)
fig,ax=plt.subplots(figsize=(9,3.6));x=np.arange(3);ax.bar(x-.18,[90,60,66],.36,color=orange,label='Reminder');ax.bar(x+.18,[80,50,74],.36,color=navy,label='Standard');ax.set(xticks=x,xticklabels=['Simple cases','Complex cases','All cases'],ylabel='On-time filings (%)',ylim=(0,100));ax.legend(frameon=False,ncol=2,loc='upper center');fig.tight_layout();fig.savefig(D/'simpson_block2.pdf');plt.close(fig)
