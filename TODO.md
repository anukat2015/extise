switch to https://github.com/thuss/standalone-migrations
or make new game - total lightweight solution based on standalone-migrations 
    
see & add to readme:

https://wiki.eclipse.org/Mylyn/Integrator_Reference#Interaction_events
https://www.bugzilla.org/docs/2.16/html/dbschema.html
http://www.ravenbrook.com/tool/bugzilla-schema/?action=single&version=3.4.2&view=View+schema


import_tasks:

#TODO after this filter review data and maybe filter even by classification, component + product
product should filter out stuff like: Build, ApiTools, etc...

import_commits:

#TODO speedup: for each repository we process only commits bound by interactions:
# commits: a,b,c,d
# a -- b -> get time -> no interactions from bugs_eclipse_org
# b -- c -> get time -> some interactions => process a and b

#TODO speedup: Extise.stream all commit files at once since calling java and loading stuff
# takes 1.5 - 2.5 sec for each source file


import_interactions:

# NOTE: other structure kinds to consider:
# resource
# aspectj
# plugin.xml
# build.xml
# DLTK
# http
# html

# NOTE: other origin identifiers to consider:
# - maybe:
# org.eclipse.ui.navigator.ProjectExplorer
# org.eclipse.ui.views.ResourceNavigator
# org.eclipse.ajdt.internal.ui.editor.CompilationUnitEditor
# org.eclipse.mylar.java.ui.editor.MylarCompilationUnitEditor
# org.eclipse.wst.jsdt.ui.CompilationUnitEditor
# - less likely:
# org.eclipse.ui.views.ContentOutline
# org.eclipse.ui.DefaultTextEditor
# org.eclipse.search.ui.views.SearchView
# org.eclipse.pde.ui.manifestEditor
# org.eclipse.jdt.callhierarchy.view
# org.eclipse.jdt.ui.PropertiesFileEditor
# org.eclipse.ant.ui.internal.editor.AntEditor
# org.eclipse.jdt.ui.TypeHierarchy
# org.eclipse.wst.xml.ui.internal.tabletree.XMLMultiPageEditorPart
# org.eclipse.compare.CompareEditor
# org.eclipse.pde.ui.featureEditor
# org.eclipse.pde.ui.buildEditor
# org.eclipse.pde.ui.schemaEditor
# org.eclipse.mylyn.tasks.ui.editors.task
# org.eclipse.pde.ui.productEditor
# org.eclipse.m2e.editor.MavenPomEditor
# - and more with < 100 interactions
