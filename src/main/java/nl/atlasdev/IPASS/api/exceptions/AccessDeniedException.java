package nl.atlasdev.IPASS.api.exceptions;

import javax.json.Json;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class AccessDeniedException extends WebApplicationException {
	private static final long serialVersionUID = 1L;

	public AccessDeniedException(String message) {
        super(Response.status(Response.Status.UNAUTHORIZED)
            .entity(Json.createObjectBuilder().add("error", "EDENIED").add("message", message).build().toString())
            .type(MediaType.APPLICATION_JSON).build());
    }
}