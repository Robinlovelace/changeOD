## code to prepare `lookups` dataset goes here

library(collapse)


u = "https://open-geography-portalx-ons.hub.arcgis.com/datasets/ons::lsoa-2011-to-lsoa-2021-to-local-authority-district-2022-lookup-for-england-and-wales-version-2.csv?where=1=1"
lookup = readr::read_csv(u)
# Save csv locally in case it disappears online:
readr::write_csv(lookup, "lsoa-2011-to-lsoa-2021-to-local-authority-district-2022-lookup-for-england-and-wales-version-2.csv")

# Search term: https://www.google.com/search?channel=fs&client=ubuntu-sn&q=2011+to+2021+msoa+lookup
# And for MSOA: starting with this URL: https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/MSOA_(2011)_to_MSOA_(2021)_to_Local_Authority_District_(2022)_Lookup_for_England_and_Wales/FeatureServer/0/query?outFields=*&where=1%3D1
u = "https://services1.arcgis.com/ESMARspQHYMw9BZ9/arcgis/rest/services/MSOA_(2011)_to_MSOA_(2021)_to_Local_Authority_District_(2022)_Lookup_for_England_and_Wales/FeatureServer/0/query?outFields=*&where=1%3D1&f=geojson"
lookup = sf::read_sf(u)
head(lookup$geometry) # geometry is empty
names(lookup)
# Keep relevant names:
#  [1] "MSOA11CD" "MSOA11NM" "CHGIND"   "MSOA21CD" "MSOA21NM" "LAD22CD" 
#  [7] "LAD22NM"  "LAD22NMW" "ObjectId" "geometry"
lookup = lookup |>
  fselect(MSOA11CD, MSOA21CD, LAD22CD, LAD22NM, CHGIND) |>
  sf::st_drop_geometry()
# Save as parquet file and upload with piggyback:
arrow::write_parquet(lookup, "msoa-2011-to-msoa-2021-to-local-authority-district-2022-lookup-for-england-and-wales-version-2.parquet")
piggyback::pb_upload("msoa-2011-to-msoa-2021-to-local-authority-district-2022-lookup-for-england-and-wales-version-2.parquet")

piggyback::pb_download_url("msoa-2011-to-msoa-2021-to-local-authority-district-2022-lookup-for-england-and-wales-version-2.parquet")
# [1] "https://github.com/Robinlovelace/changeOD/releases/download/latest/msoa-2011-to-msoa-2021-to-local-authority-district-2022-lookup-for-england-and-wales-version-2.parquet"

# Save for use in R package:
lookup_2011_2021_msoa = lookup
usethis::use_data(lookup_2011_2021_msoa, overwrite = TRUE)
