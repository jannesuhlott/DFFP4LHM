## Functions for Aggregation of crop types
# Jannes Säurich (ORCID: 0009-0003-4948-128X)

################# Crop Type Codes Summaries ##################

### Schwieder ###

### InVeKoS Level 3 for Schwieder V202 (https://zenodo.org/records/10640528)

# Input: raw_codes [CODE]
# Do: Summarise InVeKoS crop type classes to Level 3 classification
# Output: codes_I_L3 [SWD: Schwieder (after Segmentierung), I: alle InVeKoS-Codes, I_L3: InVeKoS Level 3 (after summarising)]
# Packages: dplyr, tidyverse

# (Codes) name: [IACS-Codes, (IACS Code)] (only for agrarmask; Gehölz (3001), Sonstige Flächen (3002), Brachen (3003) already excluded)
# (200) DGL: Wiesen (451), Mähweiden (452), Weiden und Almen (453), 459 (alle anderen GL Nutzungen), 441 (GL Neueinsaat), 443 (Weideneinsaat), 455 (Alemn und Alpen)
# (1101) Winterweizen: Winterhartweizen (112), Winterweichweizen (115)
# (1102) Wintergerste:  Wintergerste (131)
# (1103) Winterroggen: Winterroggen (121)
# ---- gelöscht (1104) Sonst. Winterungen: Wintertriticale (156), Winterdinkel (114)
# (1201) Springbarley: Sommergerste (132)
# (1202) Springoat: Sommerhafer (143) # gelöscht ----- Sommerweizen (116), Sommertriticale (157), Sommerroggen (122) ----
# (1300) Maize: Silomais (411), Mais (Biogas) (172), Mais mit Ackerbohne (410), Maize other (177), Mais (ohne Silomais) (171), Gem. Silomais (412)
# (1401) Potatos: Stärkekartoffel (601), Speisekartoffel (602), Pflanzkartoffel (606)
# (1402) Sugarbeet: Zuckerrüben (603)
# (1501) Winterrapeseed: Winterraps (311)
# (1502) Sunflower: Sonnenblumen (320)
# (1611) Erbsen (210), Erbsen/Bohnen (240)
# (1612) Ackerbohne: Ackerbohnen (220)
# (1613) Lupine: Lupinen (230)
# (1614) Soja: Sojabohnen (330)
# (1602) Ackerfutter:  Ackergras (424), Luzerne (423), Klee (421),  Kleegras (422), Klee-Luzerne-Gemisch (425), (433) Luzerne Gras, # gelöscht --- Wicken (221), Leguminosen (250) --- 
# (1603) Gartenbauerzeugnisse: Erdbeeren (707), Spargel (860), Zwiebeln (633), Gartenkürbis (630), Möhre (634), Gartenbohne (635), Gemüse (610), Kohl (613), Gartensalat (637), Spinat (638), sontiges Gemüse (632)
# (4001) Rebflächen: (843), (844), Rebflächen (847)
# (4002) Hopfen: Hopfen (856)
# (4003) Plantagen: sonstige Obstanlage (824), Kernobst (825), Steinobst (826), Kern- und Steinobst (821), Weihnachtsbäume (983)
# (NA)  NA 
# (777) Others: alle weiteren


get_I4SWD_L3_codes <- function(raw_codes) {
  
  # code_grassland <- raw_codes %>% 
  # filter(CODE %in% c(451, 452, 453, 459, 441, 443, 455)) %>% 
  # mutate(Code_new = 200)
  # Wiesen (451), Mähweiden (452), Weiden und Almen (453), 459 (alle anderen GL Nutzungen), 441 (GL Neueinsaat), 443 (Weideneinsaat), 455 (Alemn und Alpen)
  # -- grassland was already excluded during preparation --
  
  code_winterwheat <- raw_codes %>% 
    filter(CODE %in% c(112, 115)) %>% 
    mutate(Code_new = 1101)
  
  # Winterhartweizen (112), Winterweichweizen (115)
  
  
  code_winterrye <- raw_codes %>% 
    filter(CODE %in% c(121)) %>% 
    mutate(Code_new = 1103)
  
  # Winterroggen (121)
  
  
  code_winterbarley <- raw_codes %>% 
    filter(CODE %in% c(131)) %>% 
    mutate(Code_new = 1102)
  
  # Wintergerste (131)
  
  # code_wintercrop <- raw_codes %>%  # gelöscht, da kein 1104 in verwendeter Version
    # filter(CODE %in% c(114, 156)) %>% 
    # mutate(Code_new = 1104)
  # Wintertriticale (156), Winterdinkel (114)
  # -- 1104 not included in in V202 anymore -- 
  
  
  code_springbarley <- raw_codes %>% 
    filter(CODE %in% c(132)) %>% 
    mutate(Code_new = 1201)
  
  # Sommergerste (132)
  
  
  code_springoat <- raw_codes %>% 
    filter(CODE %in% c(143)) %>% 
    mutate(Code_new = 1202)
  
  # Sommerhafer (143), 
  # -- Sommerweizen (116), Sommertriticale (157), Sommerroggen (122) not included in V202 anymore -- 
  
  
  code_maize <- raw_codes %>% 
    filter(CODE %in% c(411, 172, 410, 177, 171, 412)) %>% 
    mutate(Code_new = 1300)
  
  # Silomais (411), Mais (Biogas) (172), Mais mit Ackerbohne (410), Maize other (177), Mais (ohne Silomais) (171), Gem. Silomais (421)
  
  
  code_potatos <- raw_codes %>% 
    filter(CODE %in% c(601, 602, 606)) %>% 
    mutate(Code_new = 1401)
  
  # Stärkekartoffel (601), Speisekartoffel (602), Pflanzkartoffel (606)
  
  
  code_sugarbeet <- raw_codes %>% 
    filter(CODE %in% c(603)) %>% 
    mutate(Code_new = 1402)
  
  # Zuckerrüben (603)  
  
  
  code_winterrapeseed <- raw_codes %>% 
    filter(CODE %in% c(311)) %>% 
    mutate(Code_new = 1501)
  
  # Winterraps (311)
  
  
  code_sunflower <- raw_codes %>% 
    filter(CODE %in% c(320)) %>% 
    mutate(Code_new = 1502)
  
  # Sonnenblumen (320)
  
  
  code_peas <- raw_codes %>% 
    filter(CODE %in% c(210, 240)) %>% 
    mutate(Code_new = 1611)
  
  # Erbsen (210), Erbsen/Bohnen (240)
  
  
  code_fieldbean <- raw_codes %>% 
    filter(CODE %in% c(220)) %>% 
    mutate(Code_new = 1612)
  
  # Ackerbohnen (220)
  
  
  code_lupine <- raw_codes %>% 
    filter(CODE %in% c(230)) %>% 
    mutate(Code_new = 1613)
  
  # Lupinen (230)
  
  
  code_soy <- raw_codes %>% 
    filter(CODE %in% c(330)) %>% 
    mutate(Code_new = 1614)
  
  # Sojabohnen (330)
  
  
  # code_fieldfodder <- raw_codes %>% 
  # filter(CODE %in% c(221, 250, 424, 423, 421, 422, 425, 433)) %>% 
  # mutate(Code_new = 1602)
  #  Wicken (221), Leguminosen (250), Ackergras (424), Luzerne (423), Klee (421),  Kleegras (422), Klee-Luzerne-Gemisch (425), (433) Luzerne Gras
  # -- fieldfodder was already excluded during preparation --
  
  
  code_horticultural <- raw_codes %>% 
    filter(CODE %in% c(707, 860, 633, 630, 634, 635, 610, 613, 637, 638, 632)) %>% 
    mutate(Code_new = 1603)
  
  # Erdbeeren (707), Spargel (860), Zwiebeln (633), Gartenkürbis (630), Möhre (634), Gartenbohne (635), Gemüse (610), Kohl (613), Gartensalat (637), Spinat (638), sontiges Gemüse (632)
  
  
  code_vine <- raw_codes %>% 
    filter(CODE %in% c(843, 844, 847)) %>% 
    mutate(Code_new = 4001)
  
  # (843), (844), Rebflächen (847)
  
  
  code_hops <- raw_codes %>% 
    filter(CODE %in% c(856)) %>% 
    mutate(Code_new = 4002)
  
  # Hopfen (856)
  
  
  code_orchard <- raw_codes %>% 
    filter(CODE %in% c(824, 825, 826, 821, 983)) %>% 
    mutate(Code_new = 4003)
  
  # sonstige Obstanlage (824), Kernobst (825), Steinobst (826), Kern- und Steinobst (821), Weihnachtsbäume (983)
  
      
  all_codes <- c(112, 115, 121, 131, 132, 143, 411, 172, 410, 177, 
                 171, 412, 601, 602, 606, 603, 311, 320, 210, 240, 220, 230, 330, 707, 860, 
                 633, 630, 634, 635, 610, 613, 637, 638, 632, 843, 844, 847, 856, 824, 825,
                 826, 821, 983) 
  # -- without 114, 156, cause 1104 not included anymore in V202
  # -- without 116, 157, 122, cause new definitions for Sommerhafer
  # -- without 221, 250, 424, 423, 421, 422, 425, 433, cause fieldfodder already excluded during prearation
  # -- without 451, 452, 453, 459, 441, 443, 455, cause grassland already excluded during preparation 
  
  code_others <- raw_codes %>% 
    filter(! CODE %in% all_codes) %>% 
    mutate(Code_new = 777)
  
  
  codes <- rbind(code_winterwheat, code_winterrye, code_winterbarley, code_springbarley, code_springoat, code_maize, 
                 code_potatos, code_sugarbeet, code_winterrapeseed, code_sunflower, code_peas, code_fieldbean, code_lupine, 
                 code_soy, code_horticultural, code_vine, code_hops, code_orchard, code_others)
  
  codes_I_L3 <- dplyr::rename(codes, I_L3 = Code_new, I = CODE)
  
  return(codes_I_L3)
}


### PREIDL ###

### Invekos4Preidl Level 3

# (0)	Not classified: /
# (1)	Winter wheat: Winterhartweizen (112), Winterweichweizen (115), Wintertriticale (156)
# (2)	Winter spelt: Winterdinkel (114)
# (3)	Winter rye: Winterroggen (121)
# (4)	Winter barley: Wintergerste (131)
# (5)	Spring wheat: Sommerhartweizen/Durum (113), Sommerweichweizen (116), Sommertriticale (157)
# (6)	Spring barley: Sommergerste (132)
# (7)	Spring oats: Sommerhafer (143)
# (8)	Maize: Mais (ohne Silomais) (171), Mais (Biogas) (172), Silomais (411)
# (9)	Root crops: Erbsen (210), Gemüseerbse (211), Ackerbohnen (220), Lupinen (230), Erbsen/Bohnen (240)
# (10)	Winter rape: Winterraps (311)
# (11)	Leek: Lauch (633)
# (12)	Potatoes: Stärkekartoffel (601), Speisekartoffel (602)
# (13)	Sugar beet: Zuckerrüben (603)
# (14)	Strawberries: Erdbeeren (707)
# (15)	Pome fruit, stone fruit: Kern- und Steinobst (821), Kernobst z.B. Äpfel, Birnen (825), Steinobst, z. B. Kirschen (826)
# (16)	Vineyards: Rebland (842), Bestockte Rebfläche (843)
# (17)  Hops: Hopfen (856)
# (18)	Asparagus: Spargel (860) 
# (19)	Grassland: Rot-/Weiß-/Alexandriner-/Inkarnat-/Erd-/Schweden-/Persischer Klee (421), Kleegras (422), Luzerne (423), Ackergras (424), Klee-Luzerne-Gemisch (425), Wiesen (Grünlandneueinsaat im Rahmen von AUKM)(441), Wiesen (451), Mähweiden (452), Weiden und Almen (453), Hutungen (454), Grünland (459) 
# (20)	Urban regions: /
# (21)	Water: /
# (22)  Other vegetation: /
# (23)	Forest: /

get_I4PRE_L3_codes <- function(raw_codes) {
  
  code_winterwheat <- raw_codes %>% 
    filter(CODE %in% c(112, 115, 156)) %>% 
    mutate(Code_new = 1)
  
  # Winterhartweizen (112), Winterweichweizen (115), Wintertriticale (156)
  
  code_winterspelt <- raw_codes %>% 
    filter(CODE %in% c(114)) %>% 
    mutate(Code_new = 2)
  
  # Winterdinkel (114)
  
  code_winterrye <- raw_codes %>% 
    filter(CODE %in% c(121)) %>% 
    mutate(Code_new = 3)
  
  # Winterroggen (121)
  
  code_winterbarley <- raw_codes %>% 
    filter(CODE %in% c(131)) %>% 
    mutate(Code_new = 4)
  
  # Wintergerste (131)
  
  code_springwheat <- raw_codes %>% 
    filter(CODE %in% c(113, 116, 157)) %>% 
    mutate(Code_new = 5)
  
  # Sommerhartweizen/Durum (113), Sommerweichweizen (116), Sommertriticale (157)
  
  code_springbarley <- raw_codes %>% 
    filter(CODE %in% c(132)) %>% 
    mutate(Code_new = 6)
  
  # Sommergerste (132)
  
  
  code_springoat <- raw_codes %>% 
    filter(CODE %in% c(143)) %>% 
    mutate(Code_new = 7)
  
  # Sommerhafer (143)
  
  code_maize <- raw_codes %>% 
    filter(CODE %in% c(171, 172, 411)) %>% 
    mutate(Code_new = 8)
  
  # Mais (ohne Silomais) (171), Mais (Biogas) (172), Silomais (411)
  
  code_legume <- raw_codes %>% 
    filter(CODE %in% c(210, 211, 220, 230, 240)) %>% 
    mutate(Code_new = 9)
  
  # Erbsen (210), Gemüseerbse (211), Ackerbohnen (220), Lupinen (230), Erbsen/Bohnen (240)
  
  code_winterrapeseed <- raw_codes %>% 
    filter(CODE %in% c(311)) %>% 
    mutate(Code_new = 10)
  
  # Winterraps (311)
  
  code_leek <- raw_codes %>% 
    filter(CODE %in% c(633)) %>% 
    mutate(Code_new = 11)
  
  # Lauch (633)
  
  code_potatos <- raw_codes %>% 
    filter(CODE %in% c(601, 602)) %>% 
    mutate(Code_new = 12)
  
  # Stärkekartoffel (601), Speisekartoffel (602)
  
  code_sugarbeet <- raw_codes %>% 
    filter(CODE %in% c(603)) %>% 
    mutate(Code_new = 13)
  
  # Zuckerrüben (603)
  
  code_strawberry <- raw_codes %>% 
    filter(CODE %in% c(707)) %>% 
    mutate(Code_new = 14)
  
  #  Erdbeeren (707)
  
  code_fruits <- raw_codes %>% 
    filter(CODE %in% c(821, 825, 826)) %>% 
    mutate(Code_new = 15)
  
  # Kern- und Steinobst (821), Kernobst z.B. Äpfel, Birnen (825), Steinobst, z. B. Kirschen (826)
  
  code_vine <- raw_codes %>% 
    filter(CODE %in% c(842, 843)) %>% 
    mutate(Code_new = 16)
  
  # Rebland (842), Bestockte Rebfläche (843)
  
  code_hops <- raw_codes %>% 
    filter(CODE %in% c(856)) %>% 
    mutate(Code_new = 17)
  
  # Hopfen (856)
  
  code_asparagus <- raw_codes %>% 
    filter(CODE %in% c(860)) %>% 
    mutate(Code_new = 18)
  
  # Spargel (860) 
  
  code_grassland <- raw_codes %>% 
    filter(CODE %in% c(421, 422, 423, 424, 425, 441, 451, 452, 453, 454, 459)) %>% 
    mutate(Code_new = 19)
  
  # Rot-/Weiß-/Alexandriner-/Inkarnat-/Erd-/Schweden-/Persischer Klee (421), Kleegras (422), Luzerne (423), Ackergras (424), Klee-Luzerne-Gemisch (425), Wiesen (Grünlandneueinsaat im Rahmen von AUKM)(441), Wiesen (451), Mähweiden (452), Weiden und Almen (453), Hutungen (454), Grünland (459) 
  
  code_others <- raw_codes %>% 
    filter(! CODE %in% c(112, 115, 156, 114, 121, 131, 113, 116, 157, 132, 143, 171, 172, 411, 210, 211, 220, 230, 240, 311, 633, 601, 602, 603, 707, 821, 825, 826, 842, 843, 856, 860, 421, 422, 423, 424, 425, 441, 451, 452, 453, 454, 459)) %>% 
    mutate(Code_new = 777)
  
  
  codes <- rbind(code_winterwheat, code_winterspelt, code_winterrye, code_winterbarley, code_springwheat, code_springbarley, code_springoat, code_maize, code_legume, code_winterrapeseed, code_leek, code_potatos, code_sugarbeet, code_strawberry, code_fruits, code_vine, code_hops, code_asparagus, code_grassland, code_others)
  
  codes_I_L3 <- dplyr::rename(codes, I_L3 = Code_new, I = CODE)
  
  return(codes_I_L3)
} 


