rm(list = ls(all=T))

library(sidrar)
library(tidyverse)
library(zoo)

setwd("~/Documentos/Projetos/observatorio/")

pib <- get_sidra(api="/t/5932/n1/all/v/6561,6562,6563/p/all/c11255/90687,90691,90696,90707,93406,93407/d/v6561%201,v6562%201,v6563%201") %>% 
  select(`Trimestre (Código)`,'Setores e subsetores',Variável,Valor,'Unidade de Medida') %>% 
  pivot_wider(names_from = `Setores e subsetores`,values_from = Valor)

# tx_trimestral <-  subset(pib, Vari?vel== "Taxa trimestral (em rela??o ao mesmo per?odo do ano anterior)")
# tx_4tri <- subset(pib, Vari?vel =="Taxa acumulada em quatro trimestres (em rela??o ao mesmo per?odo do ano anterior)")
# tx_ano <- subset(pib, Vari?vel == "Taxa acumulada ao longo do ano (em rela??o ao mesmo per?odo do ano anterior)")

write.csv(pib,"PIB")

ipca <- get_sidra(api = '/t/1737/n1/all/v/63,69,2265,2266/p/all/d/v63%202,v69%202,v2265%202,v2266%2013') %>%
  mutate(Mês = parse_date(`Mês (Código)`, format='%Y%m')) %>% 
  select(Mês,Variável,Valor) %>% 
  pivot_wider(names_from = Variável, values_from=Valor)

write.csv(ipca,"IPCA")

mensal <- 
acumulado_ano <- subset(ipca, Variável == 'IPCA - Variação acumulada no ano')
doze_meses <- subset(ipca, Variável == 'IPCA - Variação acumulada em 12 meses')
