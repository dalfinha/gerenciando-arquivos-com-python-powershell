# Metrificando arquivos com Python e PowerShell
Filtre os arquivos que você não utiliza mais via PowerShell e receba um gráfico customizado com essas informações :)



## Inspiração ⭐
Este projeto foi inspirado na aplicação <a href="https://www.jam-software.com/treesize">Treesize Professional</a>, que ajuda a metrificar e entender de forma totalmente visual o uso de um determinado diretório. 

O gráfico foi inspirado na funcionalidade "Age of Files":

![image](https://user-images.githubusercontent.com/72402847/230734165-6de6d42d-2810-4e50-a23c-1d54397d0109.png)
Reprodução por <a href="https://www.techrepublic.com/pictures/spotlight-treesize-professional-file-management/">TechPublic</a>



## Pré requisitos e informações importantes ⭐
- Você precisa ter as permissões de administrador da máquina para executar scripts do PowerShell. Lembre-se que ao tentar executar um script, a opção de execução estará desabilitada. Leia mais sobre <a href="https://social.technet.microsoft.com/wiki/pt-br/contents/articles/35641.windows-10-permitir-a-execucao-de-scripts-no-powershell.aspx">aqui</a> se você utiliza o Windows 10.

- Para que o script do PowerShell chame corretamente o script do Python, o adicione a um diretório que possui acesso. 

- Para a análise e exportação do arquivo gerado pelo PowerShell é necessário baixar as bibliotecas **`pandas`** e **`matpilotlib`**.

      pip install pandas

      pip install matpilotlib

- Nenhum módulo extra foi utilizado no script do PowerShell, o que significa que você pode executa-lo na sua Workstation sem problemas. 



## O que o script faz? ⭐

1. Via `Read-Host`, recebe um diretório.
2. Recursivamente, obtem informações como Nome do arquivo, Tamanho em Bytes e o intervalo da última vez que foi motificado até o dia em que o script será executado.
3. Ao extrair as informações ele delimita o .CSV e chama o código em Python.
4. O Python recebe os dados com a biblioteca `pandas`, transformando o arquivo em Excel.
5. Analisa as colunas, criando uma nova chamada "Categoria", que agrupa o tempo em que o arquivo foi utilizado, metrificando nas classificações 0, 30, 60, 90 dias até 365 dias. 
6. Com a biblioteca `matpilotlib`, após a criação desta nova coluna, é criado um gráfico que mostra a quantidade de arquivos não abertos a mais de X tempo e a quantidade de armazenamento que estes arquivos estão consumindo, em MB. 

  Exemplo: 

![image](https://user-images.githubusercontent.com/72402847/230734885-17460a52-296c-4630-8385-f12ff1529afb.png)

**Onde mostra - de forma agrupada - que tenho >6GB de arquivos que não utilizo a mais de 1 ano!**



## Modificações ⭐
- O script não foi testado em um ambiente de arquivos distribuídos. Se caso o teste, por favor, me informe o status da execução na Issues. 
- Você pode 'higienizar' o script em PowerShell, visto que o mesmo tenta quebrar o delimitador do arquivo. Isso só acontece para oportunidade de utilizar este CSV em outras análises ou aplicações. 
- O gráfico não está configurado para ser salvo na máquina que iniciará a execução. Caso o queira, troque o `show()` para `savefig()`.
- Não esqueça de alterar os caminhos em que o arquivo principal é gerado e salvo!
