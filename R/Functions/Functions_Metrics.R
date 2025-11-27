## Functions for Calculation of Landscape Heterogeneity Metrics (LHM)
# Jannes Säurich (ORCID: 0009-0003-4948-128X)

############ Calculation per Polygon #########################

### get_polygon_area ###

## Input: intersected with hexid, VEG
## Do: Calculate area for each polygon
## Output: intersected with area for each polygon
## Packages: sf, sp, units, lwgeom

get_polygon_area <- function(data) {
  
  ## calculate area for every patch ##
  area <- data %>%
    st_geometry(.) %>% 
    st_area(.) 
    
  area <- units::set_units(x = area, value = km^2)
  
  ## add calculations to intersected 
  data_area <- cbind(data, area)
  
  return(data_area)
}

############### Calculation per hexagon ######################################

###  get_evenness_per_hexagon ###
# Input: hexagon_data, raw_polygon_details [hexid, code, area]
# Do: Calculate Shannon-Index (H) based on area for different codes per hexagon
# Output: evenness_data
# Packages: vegan, tidyverse

get_evenness_per_hexagon  <- function(hexagon_data, raw_polygon_details) {
  
  area_per_code_data <- raw_polygon_details %>% 
    filter(!is.na(code)) %>% 
    group_by(HexagonID, code) %>%
    summarise(area_per_code = sum(area)) 
  
  evenness_output <- area_per_code_data %>%
    group_by(HexagonID) %>%
    summarise(H=diversity(area_per_code, "shannon")) %>% 
    mutate(E = H/log(specnumber(unique(area_per_code_data$code))))
  
  evenness_data <- left_join(x= hexagon_data, y=evenness_output)
  
  return (evenness_data)
}

################# Output #####################

get_hexagon_filtered <- function(data) {
  
  hexagon_filtered <- hexagon_area %>% 
    filter (hexagon_area$area >= set_units(0.999, "km^2")) %>% 
    mutate(drop_units(.))
  
  result_data <- hexagon_filtered %>% 
    select (! c(area))
  
  return (result_data)
}


################# AccMetrics ##################
 
get_AccMetrics = function(actual=NULL, 
                     predicted=NULL, 
                     cm=NULL){
  
  if(is.null(cm)) {
    naVals = union(which(is.na(actual)), which(is.na(predicted)))
    if(length(naVals) > 0) {
      actual = actual[-naVals]
      predicted = predicted[-naVals]
    }
    f = factor(union(unique(actual), unique(predicted)))
    actual = factor(actual, levels = levels(f))
    predicted = factor(predicted, levels = levels(f))
    cm = as.matrix(table(Actual=actual, Predicted=predicted))
  }
  
  n = sum(cm) # number of instances
  nc = nrow(cm) # number of classes
  diag = diag(cm) # number of correctly classified instances per class 
  rowsums = apply(cm, 1, sum) # number of instances per class
  colsums = apply(cm, 2, sum) # number of predictions per class
  p = rowsums / n # distribution of instances over the classes
  q = colsums / n # distribution of instances over the predicted classes
  
  #accuracy
  accuracy = sum(diag) / n
  
  #per class prf
  recall = diag / rowsums
  precision = diag / colsums
  f1 = 2 * precision * recall / (precision + recall)
  # data.frame(precision, recall, f1) 
  
  
  #macro prf
  macroPrecision = mean(precision,na.rm=TRUE)
  macroRecall = mean(recall,na.rm=TRUE)
  macroF1 = mean(f1,na.rm=TRUE)
  weightedF1 = sum(f1 * rowsums, na.rm = TRUE) / sum(rowsums)
  
  macro <- data.frame(macroPrecision, macroRecall, macroF1)
  
  #1-vs-all matrix
  oneVsAll = lapply(1 : nc,
                    function(i){
                      v = c(cm[i,i],
                            rowsums[i] - cm[i,i],
                            colsums[i] - cm[i,i],
                            n-rowsums[i] - colsums[i] + cm[i,i]);
                      return(matrix(v, nrow = 2, byrow = T))})
  
  s = matrix(0, nrow=2, ncol=2)
  for(i in 1:nc){s=s+oneVsAll[[i]]}
  
  #avg accuracy
  avgAccuracy = sum(diag(s))/sum(s)
  
  #micro prf
  microPrf = (diag(s) / apply(s,1, sum))[1];
  
  #majority class
  mcIndex = which(rowsums==max(rowsums))[1] # majority-class index
  mcAccuracy = as.numeric(p[mcIndex]) 
  mcRecall = 0*p;  mcRecall[mcIndex] = 1
  mcPrecision = 0*p; mcPrecision[mcIndex] = p[mcIndex]
  mcF1 = 0*p; mcF1[mcIndex] = 2 * mcPrecision[mcIndex] / (mcPrecision[mcIndex] + 1)
  
  # majortity <- data.frame(mcRecall, mcPrecision, mcF1)
  
  #random/expected accuracy
  expAccuracy = sum(p*q)
  #kappa
  kappa = (accuracy - expAccuracy) / (1 - expAccuracy)
  
  #random guess
  rgAccuracy = 1 / nc
  rgPrecision = p
  rgRecall = 0*p + 1 / nc
  rgF1 = 2 * p / (nc * p + 1)
  
  #randomweighted guess
  rwgAccurcy = sum(p^2)
  rwgPrecision = p
  rwgRecall = p
  rwgF1 = p
  
  classNames = names(diag)
  if(is.null(classNames)) classNames = paste("C",(1:nc),sep="")
  
  AccMetrics = rbind(
    Accuracy = accuracy,
    Precision = precision,
    Recall = recall,
    F1 = f1,
    MacroAvgPrecision = macroPrecision,
    MacroAvgRecall = macroRecall,
    MacroAvgF1 = macroF1,
    WeightedAvgF1 = weightedF1,
    AvgAccuracy = avgAccuracy,
    MicroAvgPrecision = microPrf,
    MicroAvgRecall = microPrf,
    MicroAvgF1 = microPrf,
    MajorityClassAccuracy = mcAccuracy,
    MajorityClassPrecision = mcPrecision,
    MajorityClassRecall = mcRecall,
    MajorityClassF1 = mcF1,
    Kappa = kappa,
    RandomGuessAccuracy = rgAccuracy,
    RandomGuessPrecision = rgPrecision,
    RandomGuessRecall = rgRecall,
    RandomGuessF1 = rgF1,
    RandomWeightedGuessAccuracy = rwgAccurcy,
    RandomWeightedGuessPrecision = rwgPrecision,
    RandomWeightedGuessRecall = rwgRecall,
    RandomWeightedGuessF1 = rwgF1)
  colnames(AccMetrics) = classNames
  return(list(ConfusionMatrix = cm, AccMetrics = AccMetrics))
}

################# PLOT THEMES ################

### MonViA Theme 

### define own theme
# white background with grey gridlines

theme_monvia <- function(base_size = 14){
  theme_gray(base_size = base_size) %+replace%
    theme(
      panel.background = element_rect(fill = 'white', color = 'grey'), 
      panel.grid = element_line(color = 'grey')
    )
}
