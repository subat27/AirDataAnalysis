package clover.datalab.airdata.http.controllers;

import org.springframework.stereotype.Controller;

import clover.datalab.airdata.services.EditRequestService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class EditRequestController {
	
	private final EditRequestService service;
}
