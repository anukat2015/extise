switch to https://github.com/thuss/standalone-migrations
  or make new game - total lightweight solution based on standalone-migrations 

extisimo:
  review models in schema.dia

each extitimo:
  bugs_eclipse_org_attachment_id

def scopes for each extisimo model:
  concern time_range for session, commit, task, interaction, expertise, post, attachment
    check if rails supports this
    interaction.from().to()
    interaction.between()
    
  no interaction.of_session() -> rather session.interactions 

see & add to readme:

https://wiki.eclipse.org/Mylyn/Integrator_Reference#Interaction_events
https://www.bugzilla.org/docs/2.16/html/dbschema.html
http://www.ravenbrook.com/tool/bugzilla-schema/?action=single&version=3.4.2&view=View+schema

