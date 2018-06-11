##' Do Call Rbind on list of dataframes
##' @param list of dataframes
##' @return df row-bound concatenated dataframe
dcrb <- function(list_of_dataframes) {
    do.call("rbind", list_of_dataframes)
}

##' Convert json to dataframe for xyz R and l and euler angles with timestamp.
##' useful for VR data recorded with the vectorMatch game
##' @param json_object structure as returned from jsonlite::read_json
##' @return res dataframe that contains right_position_x, timestamp, etc.
convert_json_to_df <- function(json_object) {
    timestamp <- unlist(json_object$timestamp)
    print('extracting positions')
    l_position <- lapply(json_object$leftPosition, unlist) %>% dcrb
    r_position <- lapply(json_object$rightPosition, unlist) %>% dcrb
    print('extracting eulers')
    l_euler <- lapply(json_object$leftEuler, unlist) %>% dcrb
    r_euler    <- lapply(json_object$rightEuler, unlist) %>% dcrb

    colnames(l_position) <- c("left_position_x", "left_position_y", "left_position_z")
    colnames(r_position) <- c("right_position_x", "right_position_y", "right_position_z")
    colnames(l_euler) <- c("left_rotation_x", "left_rotation_y", "left_rotation_z")
    colnames(r_euler) <- c("right_rotation_x", "right_rotation_y", "right_rotation_z")

    res <- cbind(timestamp = timestamp, l_position, l_euler,r_position, r_euler) %>% as.data.frame

    return(res)
}