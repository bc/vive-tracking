##' convert json to dataframe for xyz R and l and euler angles with timestamp.
##' useful for VR data recorded with the vectorMatch game
##' @param json_object structure as returned from jsonlite::read_json
##' @return res dataframe that contains right_position_x, timestamp, etc.
convert_json_to_df <- function(json_object) {
    timestamp <- unlist(a$timestamp)
    r_position <- do.call("rbind", lapply(json_object$rightPosition, as.data.frame))
    r_euler <- do.call("rbind", lapply(json_object$rightEuler, as.data.frame))
    l_position <- do.call("rbind", lapply(json_object$leftPosition, as.data.frame))
    l_euler <- do.call("rbind", lapply(json_object$leftEuler, as.data.frame))

    colnames(r_position) <- c("right_position_x", "right_position_y", "right_position_z")
    colnames(r_euler) <- c("right_rotation_x", "right_rotation_y", "right_rotation_z")
    colnames(l_position) <- c("left_position_x", "left_position_y", "left_position_z")
    colnames(l_euler) <- c("left_position_x", "left_position_y", "left_position_z")

    res <- cbind(timestamp = timestamp, r_position, r_euler, l_position, l_euler)

    return(res)
}