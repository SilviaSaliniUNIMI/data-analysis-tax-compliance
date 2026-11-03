from pathlib import Path
import statistics as st
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
TEX = Path(__file__).resolve().parent.parent
turnover = [18,20,20,22,24,25,28,30,32,35,38,40,42,45,48,50,55,60,65,70,80,95,120,300]
plt.rcParams.update({'font.family':'DejaVu Sans','font.size':12,'axes.spines.top':False,'axes.spines.right':False,'axes.labelcolor':'#18334c','text.color':'#18334c','axes.edgecolor':'#9ba9b4','savefig.bbox':'tight'})
navy='#123452';teal='#B34C12';orange='#cd713b'
fig,axs=plt.subplots(1,2,figsize=(10.2,3.6))
axs[0].bar(['Commerce','Services','Manufact.'],[12,8,4],color=teal);axs[0].set_ylabel('Number of firms');axs[0].set_ylim(0,14)
axs[1].hist(turnover,bins=[0,25,50,75,100,125,150,175,200,225,250,275,300],color=navy,edgecolor='white');axs[1].set_xlabel('Turnover (thousand EUR)');axs[1].set_ylabel('Number of firms')
fig.tight_layout();fig.savefig(TEX/'figures/distributions.pdf');plt.close(fig)
fig,ax=plt.subplots(figsize=(9,3.1));ax.scatter(turnover,[0]*24,color=teal,s=50,alpha=.65);ax.axvline(st.mean(turnover),color=orange,lw=2,label=f'Mean = {st.mean(turnover):.2f}');ax.axvline(st.median(turnover),color=navy,lw=2,label=f'Median = {st.median(turnover):.2f}');ax.set_yticks([]);ax.set_xlabel('Turnover (thousand EUR)');ax.legend(frameon=False,loc='upper right');ax.spines['left'].set_visible(False);fig.tight_layout();fig.savefig(TEX/'figures/centre.pdf');plt.close(fig)
fig,ax=plt.subplots(figsize=(9,3.4))
for i,(arr,label) in enumerate([([18,19,20,21,22],'A: concentrated'),([0,10,20,30,40],'B: dispersed')]):
 ax.scatter(arr,[1-i]*5,s=100,color=[teal,orange][i]);ax.text(43,1-i,label,va='center')
ax.axvline(20,color=navy,ls='--');ax.set_xlim(-3,70);ax.set_ylim(-.7,1.7);ax.set_yticks([]);ax.set_xlabel('Filing delay (days)');ax.spines['left'].set_visible(False);fig.tight_layout();fig.savefig(TEX/'figures/spread.pdf');plt.close(fig)

