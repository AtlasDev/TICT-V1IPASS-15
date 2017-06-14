package nl.atlasdev.IPASS.api.exceptions;

import javax.json.Json;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

public class NotFoundException extends WebApplicationException {
	private static final long serialVersionUID = 1L;

	public NotFoundException(String message) {
        super(Response.status(Response.Status.NOT_FOUND)
            .entity(Json.createObjectBuilder().add("error", "ENOTFOUND").add("message", message).build().toString())
            .type(MediaType.APPLICATION_JSON).build());
    }
}