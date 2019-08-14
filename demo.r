  #C:\Users\Shrikrishna\OneDrive - The University of Melbourne\Assignment\Winter19\Assignments\Major Assignment\pop density mel
  
  #libraries
  library(sf)
  library(ggplot2)
  library(tmap)
  library(tmaptools)
  library(leaflet)
  library(dplyr)
  
  setwd("C:/Users/Shrikrishna/OneDrive - The University of Melbourne/Assignment/Winter19/Major Assignment/r-geoserver-master")
  
  source("rgs_utils.R")
  
  mel_population_wfs = "http://45.113.235.54:8080/geoserver/a2z_ws_8/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=a2z_ws_8:popdensity_mel_4db87f85-9bac-4116-a24e-d6c6f7d19ae8&outputFormat=application%2Fjson"
  mel_buffer_wfs = "http://45.113.235.54:8080/geoserver/a2z_ws_8/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=a2z_ws_8:bufferPct_mel_5cf9a438-71fd-4046-9f3a-028f3cb049a3&outputFormat=application%2Fjson"
  mel_work_wfs = "http://45.113.235.54:8080/geoserver/a2z_ws_8/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=a2z_ws_8:workMethodPct_mel_c7b2341b-7020-49f8-8396-4175fc31bb02&outputFormat=application%2Fjson"
  mel_poverty_wfs = "http://45.113.235.54:8080/geoserver/a2z_ws_indicator_8/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=a2z_ws_indicator_8:poverty_gmel_12c48d43-d11d-4871-b8ba-6bafdd32ccf8&outputFormat=application%2Fjson"
  mel_education_wfs = "http://45.113.235.54:8080/geoserver/a2z_ws_indicator_8/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=a2z_ws_indicator_8:edu_gmel_529ca135-93a2-4ed4-ad21-0faf28b4412f&outputFormat=application%2Fjson"
  mel_gender_wfs = "http://45.113.235.54:8080/geoserver/a2z_ws_indicator_8/ows?service=WFS&version=1.0.0&request=GetFeature&typeName=a2z_ws_indicator_8:gender_gmel_d5ff0943-b239-448f-8ac8-ee3470079f95&outputFormat=application%2Fjson"
  
  mel_population_map = utils.loadGeoJSON2SP(mel_population_wfs)
  mel_buffer_map = utils.loadGeoJSON2SP(mel_buffer_wfs)
  mel_ptv_map = utils.loadGeoJSON2SP(mel_work_wfs)
  mel_bicycle_map = utils.loadGeoJSON2SP(mel_work_wfs)
  mel_walk_map = utils.loadGeoJSON2SP(mel_work_wfs)
  mel_poverty_map = utils.loadGeoJSON2SP(mel_poverty_wfs)
  mel_education_map = utils.loadGeoJSON2SP(mel_education_wfs)
  mel_gender_map = utils.loadGeoJSON2SP(mel_gender_wfs)
  
  tm_shape(mel_population_map) + 
    tm_polygons("density", id = "s2_nm16", palette="YlOrRd", n = 5, title= "Population Density") +
    tm_shape(mel_buffer_map) +
    tm_polygons("bffrPct", id = "s2_nm16", palette="Greys", n = 5, title= "Closeness to PT") +
    tm_shape(mel_ptv_map) +
    tm_polygons("pblc_pc", id = "s2_nm16", palette="Blues", n = 5, title= "Work by PT") +
    tm_shape(mel_bicycle_map) +
    tm_polygons("bcycl_p", id = "s2_nm16", palette="Purples", n = 5, title= "Work by Bicycle") +
    tm_shape(mel_walk_map) +
    tm_polygons("wlk_pct", id = "s2_nm16", palette="Greens", n = 5, title= "Work by Walk") +
    tm_shape(mel_poverty_map) +
    tm_polygons("n_pvrty", id = "s2_nm16", palette="GnBu", n = 5, title= "Poverty Indicator") +
    tm_shape(mel_education_map) +
    tm_polygons("ed_pr", id = "s2_n16", palette="PuRd", n = 5, title= "Education Indicator") +
    tm_shape(mel_gender_map) +
    tm_polygons("d____", id = "s2_n16", palette="Blues", n = 5, title= "Gender Equality")
    
  tmap_mode("view")
  tmap_last()
  testmap <- tmap_last()
  tmap_save(testmap, "testmaps.html")