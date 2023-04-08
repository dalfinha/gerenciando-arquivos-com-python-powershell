import pandas as pd
import matplotlib.pyplot as plt

# Ler arquivo CSV
dataframe = pd.read_csv('C:\\Arquivo_Novo.csv', delimiter= ';')
dataframe.to_csv('C:\\Arquivo_Novo.csv', sep=';', index=False)
dataframe.to_excel('C:\\Arquivo_Novo.xlsx',index=False)
dataframe = pd.read_excel('C:\\Arquivo_Novo.xlsx')

dataframe['Idade dos Arquivos'] = dataframe['Tempo s/ uso']
dataframe['Categoria'] = pd.cut(dataframe['Idade dos Arquivos'],
                                bins=[0,30,45,60,100,365],
                                labels=['1mês ', '>1 mês', '2 meses',  '>3 meses', '> 1 ano'])
agrupcol = dataframe.groupby('Categoria').sum()

# Definir as cores correspondentes às categorias
cores = ['palegreen', 'green', 'yellow', 'orange', 'red']

# Criar gráfico de barras com as cores definidas
plt.bar(agrupcol.index, agrupcol['Tamanho (Bytes)']/1000000, color=cores)
plt.xlabel('Tempo sem uso (Categoria)')
plt.ylabel('Tamanho Total (MB)')
plt.title('Arquivos sem utilização')
plt.show()

print(dataframe.head())
