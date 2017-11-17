test <- function(env) {
    req <- Request$new(env)
    res <- Response$new()
    
    request_method <- env[['REQUEST_METHOD']]
    rook_input <- env[['rook.input']]$read()
    content_type <- env[['CONTENT_TYPE']]
    
    req_args <- if (request_method == 'GET') {
        req$GET()
    } else {
        # only accept application/json
        if (!grepl('application/json', content_type, ignore.case = TRUE)) {
            NULL
        } else if (length(rook_input) == 0) {
            NULL
        } else {
            if (is.raw(rook_input))
                rook_input <- rawToChar(rook_input)
            rjson::fromJSON(rook_input)
        }
    }
    
    if (!is.null(req_args)) {
        wait <- if ('wait' %in% names(req_args)) req_args$wait else 1
        n <- if ('n' %in% names(req_args)) req_args$n else 10
        Sys.sleep(wait)
        list(
            status = 200,
            headers = list('Content-Type' = 'application/json'),
            body = rjson::toJSON(list(value=n))
        )
    } else {
        list(
            status = 400,
            headers = list('Content-Type' = 'application/json'),
            body = rjson::toJSON(list(message='No parameters specified'))
        )
    }
}