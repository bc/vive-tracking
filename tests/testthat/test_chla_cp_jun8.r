context("CHLA_data")
test_that("chla_CP patient data functional",{
	filepath <- "/Users/briancohn/Resilio\ Sync/CHLA_data/trial_4.txt"
	df <- read_json(filepath) %>% convert_json_to_df
	write.csv(df, "../../output/trial_4.csv", row.names=FALSE)
})