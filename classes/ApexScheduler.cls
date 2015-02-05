global class ApexScheduler implements Schedulable {
	global void execute(SchedulableContext sc) {
			RightmoveLeadService.getRightMoveLeads();
	}
}