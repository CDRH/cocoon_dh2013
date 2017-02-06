<?xml version="1.0"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:functx="http://www.functx.com"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0">
    
    <xsl:function 
        name="functx:capitalize-first" 
        xmlns:functx="http://www.functx.com" >
    
        <xsl:param name="arg"/> 
        
        <xsl:sequence select=" 
            concat(upper-case(substring($arg,1,1)),
            substring($arg,2))
            "/>
    </xsl:function>
    
    <xsl:function name="functx:words-to-camel-case" 
        xmlns:functx="http://www.functx.com" >
        <xsl:param name="arg"/> 
        
        <xsl:sequence select=" 
            for $word in tokenize($arg,'\s+')
            return functx:capitalize-first($word)
            "/>
    </xsl:function>

    <xsl:template name="mainContent">
        
<!-- TESTING CODE ==================================================================== -->

<!--        <p style="font-size:.8em;">For testing, variable list:</p>
<ul style="font-size:.8em;">
    <li>pagetype: <xsl:value-of select="$pagetype"/></li>
    <li>subpagetype: <xsl:value-of select="$subpagetype"/></li>
    <li>q: <xsl:value-of select="$q"/></li>
    <li>fq: <xsl:value-of select="$fq"/></li>
    <li>pageid: <xsl:value-of select="$pageid"/></li>
    <li>searchtype: <xsl:value-of select="$searchtype"/></li>
    <li>sort: <xsl:value-of select="$sort"/></li>
    <li>start: <xsl:value-of select="$start"/></li>
    <li>rows: <xsl:value-of select="$rows"/></li>
</ul>-->

        
        <!-- =====================================================================================
        Main Pages - Home
        ===================================================================================== -->

        <xsl:if test="$pagetype = 'home'">
            
        
            <div class="browse_page abstracts_list">
            <h3>List by:</h3>
            
            <ul class="browse_abstracts">
                <li><a href="{$siteroot}abstracts/browse.html?fq=category:Panel">Panels</a></li>
                <li><a href="{$siteroot}abstracts/browse.html?fq=category:Paper">Papers</a></li>
                <li><a href="{$siteroot}abstracts/browse.html?fq=category:Plenary">Plenary</a></li>
                <li><a href="{$siteroot}abstracts/browse.html?fq=category:Poster">Posters</a></li>
                <li><a href="{$siteroot}abstracts/browse.html?fq=category:Workshops">Workshops</a></li>
                <li><a href="{$siteroot}abstracts/browse.html?fq=category:*">All</a></li>
            </ul>
            </div>
            
            <div class="browse_page abstracts_browse">
            <h3>Browse by:</h3>
            
            <ul class="browse_abstracts">
                <li><a href="{$siteroot}abstracts/author.html">Author</a></li>
                <li><a href="{$siteroot}abstracts/date_day.html">Date</a></li>
                <li><a href="{$siteroot}abstracts/session.html">Place</a></li>
                <li><a href="{$siteroot}abstracts/keywords.html">Keywords</a></li>
                <li><a href="{$siteroot}abstracts/topic.html">Topic</a></li>
                <li><a href="{$siteroot}abstracts/combo_keywords.html">Normalized &amp; combined topic and keywords</a></li>
                <li><a href="{$siteroot}abstracts/affiliation.html">Affiliation</a></li>
            </ul>
            </div>
            
            <div class="browse_page abstracts_search">
            <h3>Search Abstracts:</h3>
            <form action="{$siteroot}abstracts/search.html" method="get" enctype="application/x-www-form-urlencoded">
                <input id="basic-q" type="text" name="q" value="" class="textField"/>
                <p class="submit">
                    <input type="submit" value="Search Abstracts" class="submit"/>
                </p> 
            </form>
            </div>
            
            <div class="browse_page abstracts_downloads">
            <h3>Downloads:</h3>
            <ul>
                <li>PDF of abstracts <a href="{$siteroot}abstracts/files/downloads/DH2013_conference_abstracts_print.pdf">Print Version</a> (68MB) | <a href="{$siteroot}abstracts/files/downloads/DH2013_conference_abstracts_web.pdf">Web Version</a> (91MB)</li>
                <li><a href="{$siteroot}abstracts/files/downloads/DH2013_corpus_file.xml">TEI Corpus file of all abstracts</a> (4.1MB)</li>
                <li><a href="{$siteroot}abstracts/files/downloads/DH2013_xml.zip">Zipped file of all TEI</a> (1.3MB)</li>
            </ul>
            </div>
            
            <div class="browse_page abstracts_view">
            <h3>View:</h3>
            
            <ul>
                <li><a href="http://dh2013.unl.edu/schedule-and-events/program/">Program</a></li>
            </ul>
            </div>
            
        </xsl:if> <!-- /main pages -->
        
        <!-- =====================================================================================
        Program
        ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'program'">
            
            <!-- Call solrsearchurl template -->
            <xsl:variable name="solrsearchurl">
                <xsl:call-template name="solrURL">
                    <xsl:with-param name="rowstart"><xsl:value-of select="$start"/></xsl:with-param>
                    <xsl:with-param name="rowend"><xsl:value-of select="$rows"/></xsl:with-param>
                    <xsl:with-param name="searchfields">id,title,author,category,topic,date_sort,date_time,date_day,session,session_type</xsl:with-param>
                    <xsl:with-param name="facet">true</xsl:with-param>
                    <xsl:with-param name="sort">date_sort</xsl:with-param>
                </xsl:call-template>
            </xsl:variable>
            
            <!-- uncomment to see the solr url for testing -->
            <!--[[[<a href="{$solrsearchurl}" target="_blank">Solr Search URL</a>]]]-->
            
            
            <!-- Call solr document -->
            <xsl:for-each select="document($solrsearchurl)">
                
                
            </xsl:for-each>
            
        </xsl:if>

        
        <!-- =====================================================================================
        Browse and Search
        ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'browse' or
                      $pagetype = 'search'">
            <xsl:choose>
                <xsl:when test="$pagetype = 'search' and $q = ''">
                    <h3>Search Abstracts</h3>
                    <form action="{$siteroot}abstracts/search.html" method="get" enctype="application/x-www-form-urlencoded">
                        <input id="basic-q" type="text" name="q" value="" class="textField"/>
                        <p class="submit">
                            <input type="submit" value="Search Texts" class="submit"/>
                        </p>    
                    </form>
                </xsl:when>
                <xsl:when test="$pagetype = 'search'">
                    <h3>Search Results</h3>
                    <!--<xsl:call-template name="search-generated-page"/>-->
                </xsl:when>
                <xsl:when test="$pagetype = 'browse'">
                    <h3>Browse All Abstracts</h3>
                    <!--<xsl:call-template name="search-generated-page"/>-->
                </xsl:when>
            </xsl:choose>
            
            <xsl:call-template name="search-generated-page"/>
 
        </xsl:if>
        
        <!-- =====================================================================================
        author | keywords | affiliation |date | other facets
        ===================================================================================== -->
        
        <xsl:if test="$pagetype = 'facets'">
            
            <h3><xsl:value-of select="concat(upper-case(substring(translate($subpagetype,'_',' '), 1, 1)), substring(translate($subpagetype,'_',' '), 2))"/></h3>
            <xsl:variable name="subtitle"></xsl:variable>
            <xsl:variable name="filterquery"><xsl:value-of select="$subpagetype"/>:&quot;</xsl:variable>
            <xsl:variable name="q_normalized">
                <xsl:choose>
                    <xsl:when test="$subpagetype = 'author' or
                        $subpagetype = 'keywords' or
                        $subpagetype = 'topic' or
                        $subpagetype = 'affiliation'">
                        <xsl:value-of select="substring-after($q, '||')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$q"></xsl:value-of>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:choose>
                <xsl:when test="$q = '*:*'">
                   <xsl:call-template name="facet-list"/>
               </xsl:when>
               <xsl:otherwise>
                   <h4><xsl:value-of select="substring-before($q_normalized,'&quot;')"/></h4>
                   <xsl:call-template name="search-generated-page"/>
               </xsl:otherwise>
           </xsl:choose>
            
 
            
        </xsl:if>
    
        <!-- =====================================================================================
        doc Display
        ===================================================================================== -->
        
        <xsl:if test="$pageid != ''">
            
           <xsl:apply-templates/>
            
            <hr/>
            
            
            
        </xsl:if>

    </xsl:template>

    <!-- =====================================================================================
        search-generated-page - For pages featuring search listings (most of them)
        ===================================================================================== -->
    
    <xsl:template name="search-generated-page" xpath-default-namespace="">
        
        <!-- Call solrsearchurl template -->
        <xsl:variable name="solrsearchurl">
            <xsl:call-template name="solrURL">
                <xsl:with-param name="rowstart"><xsl:value-of select="$start"/></xsl:with-param>
                <xsl:with-param name="rowend"><xsl:value-of select="$rows"/></xsl:with-param>
                <xsl:with-param name="searchfields">id,title,title_sort,author,author_list,category,topic,keywords,affiliation,date_sort,date_time,date_day,session,session_type</xsl:with-param>
                <xsl:with-param name="facet">true</xsl:with-param>
                <xsl:with-param name="fq">
                    <xsl:choose>
                        <xsl:when test="$fq != ''"><xsl:value-of select="$fq"/></xsl:when>
                        <xsl:when test="$pagetype = 'search'"></xsl:when>
                        <xsl:when test="$subpagetype = 'all'"></xsl:when>
                        <xsl:otherwise></xsl:otherwise>
                    </xsl:choose>
                    </xsl:with-param>
                <xsl:with-param name="facetfield">{!ex=dt}category</xsl:with-param>
                <xsl:with-param name="other">
                    <xsl:if test="$pagetype = 'facets'">
                        <xsl:text>&amp;facet.field=</xsl:text><xsl:value-of select="$subpagetype"/>
                    </xsl:if>
                    <xsl:text>&amp;facet.limit=-10</xsl:text>
                    <xsl:text>&amp;facet.mincount=1</xsl:text>
                    <xsl:text>&amp;facet.sort=index</xsl:text>
                    <!--<xsl:text>&amp;facet.limit=-1</xsl:text>-->
                    <!--<xsl:text>&amp;facet.field={!ex=dt}category</xsl:text>
                    <xsl:text>&amp;facet.field={!ex=dt}provenance</xsl:text>-->
                    <!--<xsl:if test="$pagetype = 'search' and $subpagetype != 'all'"><xsl:text>&amp;fq={!tag=dt}category:</xsl:text><xsl:value-of select="$subpagetype"/></xsl:if>-->
                </xsl:with-param>
                <xsl:with-param name="q">
                    <xsl:choose>
                        <xsl:when test="$q != ''"><xsl:value-of select="$q"/></xsl:when>
                        <xsl:otherwise><xsl:text>category:</xsl:text><xsl:value-of select="$pagetype"/></xsl:otherwise>
                    </xsl:choose>
                </xsl:with-param>
                <xsl:with-param name="sort">
                    <xsl:choose>
                        <xsl:when test="$sort != ''">
                            <xsl:value-of select="$sort"/>
                        </xsl:when>
                        <xsl:when test="$pagetype = 'browse'">
                            <xsl:text>title_sort</xsl:text>
                        </xsl:when>
                        <xsl:when test="$pagetype = 'search'">
                            <xsl:text>relevance</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>title_sort</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <!-- uncomment to see the solr url for testing -->
        <!--[[[<a href="{$solrsearchurl}" target="_blank">Solr Search URL</a>]]]-->
      
        
        <!-- Call solr document -->
        <xsl:for-each select="document($solrsearchurl)">
            
            
            <!-- Begin faceting - cycle through facets -->
      <!-- <xsl:if test="$pagetype != 'facets'">-->
                <div class="browse_options">
            <h4>Browse by type:</h4>
            <xsl:for-each select="//lst[@name='category']/int">
                <xsl:variable name="fq_instance">category:<xsl:value-of select="@name"/></xsl:variable>
                <xsl:choose>
                    <xsl:when test="$fq != $fq_instance">
                        <a>
                            <xsl:attribute name="href">
                                <xsl:call-template name="urlbuilder">
                                    <xsl:with-param name="fq">category:<xsl:value-of select="@name"/></xsl:with-param>
                                    <xsl:with-param name="sort"><xsl:value-of select="$sort"/></xsl:with-param>
                                </xsl:call-template>
                            </xsl:attribute>
                            <xsl:value-of select="@name"/> <xsl:text> (</xsl:text><xsl:value-of select="."/><xsl:text>)</xsl:text>
                        </a>
                    </xsl:when>
                    <!-- remove link when on selected page -->
                    <xsl:otherwise>
                        <xsl:value-of select="@name"/> <xsl:text> (</xsl:text><xsl:value-of select="."/><xsl:text>)</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                
                <!-- if more than one facet, show all choice -->
                <xsl:if test="not(position() = last())"><xsl:text> | </xsl:text></xsl:if>
            </xsl:for-each>
            <xsl:if test="count(//lst[@name='category']/int) &gt; 1">
                <xsl:text> | </xsl:text>
                <xsl:choose>
                    <xsl:when test="$fq != 'category:*' and  $fq != ''">
                        <a>
                    <xsl:attribute name="href">
                        <xsl:call-template name="urlbuilder">
                            <xsl:with-param name="fq">category:*</xsl:with-param>
                            <xsl:with-param name="sort"><xsl:value-of select="$sort"/></xsl:with-param>
                        </xsl:call-template>
                    </xsl:attribute>
                    <xsl:if test="$fq = 'category:*'">
                        <xsl:attribute name="class">selected</xsl:attribute>
                    </xsl:if>
                            <xsl:text>All (</xsl:text><xsl:value-of select="sum(//lst[@name='category']/int[@name])"/><xsl:text>)</xsl:text>
                </a>
                    </xsl:when>
                    <!-- remove link when on selected page -->
                    <xsl:otherwise><xsl:text>All (</xsl:text><xsl:value-of select="sum(//lst[@name='category']/int[@name])"/><xsl:text>)</xsl:text></xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            
                </div>
            <!-- end faceting -->
       <!--</xsl:if>-->
            <!-- begin sorting -->
                <xsl:if test="/response/result/@numFound &gt; 1">

            <div class="sort_options">
                <h4>Sort by:</h4>
                <xsl:choose>
                    <xsl:when test="$sort = 'title_sort' or ($pagetype = 'browse' and $sort = '')">
                        <xsl:text>Title</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:call-template name="urlbuilder">
                                    <xsl:with-param name="fq"><xsl:value-of select="$fq"/></xsl:with-param>
                                    <xsl:with-param name="sort">title_sort</xsl:with-param>
                                </xsl:call-template>
                            </xsl:attribute>
                            <xsl:text>Title</xsl:text>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>
                
                <!-- ID sort, useful for testing -->
                
               <!-- <xsl:text> | </xsl:text>
                <xsl:choose>
                    <xsl:when test="$sort = 'id'">
                        <xsl:text>ID</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:call-template name="urlbuilder">
                                    <xsl:with-param name="fq"><xsl:value-of select="$fq"/></xsl:with-param>
                                    <xsl:with-param name="sort">id</xsl:with-param>
                                </xsl:call-template>
                            </xsl:attribute>
                            <xsl:text>ID</xsl:text>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>-->
                
                <!-- Date Sort -->
                <xsl:text> | </xsl:text>
                <xsl:choose>
                    <xsl:when test="$sort = 'date_sort'">
                        <xsl:text>Date</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:call-template name="urlbuilder">
                                    <xsl:with-param name="fq"><xsl:value-of select="$fq"/></xsl:with-param>
                                    <xsl:with-param name="sort">date_sort</xsl:with-param>
                                </xsl:call-template>
                            </xsl:attribute>
                            <xsl:text>Date</xsl:text>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>
                
                <xsl:if test="$pagetype = 'search'"><xsl:text> | </xsl:text>
                <xsl:choose>
                    <xsl:when test="$sort = 'relevance' or ($sort = '' and $pagetype = 'search')">
                        <!-- no link, already the sort -->
                        <xsl:text>Relevance</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:call-template name="urlbuilder">
                                    <xsl:with-param name="fq"><xsl:value-of select="$fq"/></xsl:with-param>
                                    <xsl:with-param name="sort">relevance</xsl:with-param>
                                </xsl:call-template>
                            </xsl:attribute>
                            <xsl:text>Relevance</xsl:text>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>
                </xsl:if>

            </div><!-- end sort div -->
                </xsl:if><!-- end greater than 1 result check -->
       <!--</xsl:if>-->
            <!-- End check for facets pagetype -->
            
            <!-- end sorting -->


            <xsl:variable name="numFound" select="//result/@numFound"/>
            <!-- Call pagination -->   
            
           <!-- <xsl:call-template name="paginationLinks">
                <xsl:with-param name="numFound" select="$numFound"/>
                <xsl:with-param name="start" select="$start"/>
                <xsl:with-param name="rows" select="$rows"/>
            </xsl:call-template>-->
            <!-- <xsl:if test="$pagetype != 'facets'">-->
            <xsl:if test="$q != '' and $q != '*:*' and $pagetype != 'facets'">
               <h5>Your search for: &#8220;<xsl:value-of select="$q"/>&#8221; returned <xsl:value-of select="/response/result/@numFound"/> result<xsl:if test="not(/response/result/@numFound = 1)">s</xsl:if></h5>
           </xsl:if>
                    
             
            
            <ul class="search_results">
                <xsl:for-each select="/response/result/doc">
                    <li>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="str[@name='id']"/>
                                <xsl:text>.html</xsl:text>
                            </xsl:attribute>
                            <xsl:if test="str[@name='date_day'] = 'Withdrawn'">
                                <xsl:attribute name="class">
                                    <xsl:text>withdrawn</xsl:text>
                                </xsl:attribute>
                            </xsl:if>
                           
                            
                            <!--<xsl:value-of select="str[@name='id']"/> - -->
                            <span class="results_day"><xsl:value-of select="str[@name='date_day']"/>
                                <xsl:if test="str[@name='date_day'] != 'Withdrawn'">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="str[@name='date_time']"/></span>
                            <span class="results_session"><xsl:value-of select="str[@name='session_type']"/>
                                <xsl:if test="str[@name='date_day'] != 'Withdrawn'">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="str[@name='session']"/></span>
                            <span class="results_title"><xsl:value-of select="str[@name='title']"/></span> 
                            <span class="author_list"><em><xsl:value-of select="str[@name='author_list']"/></em></span>
                            
                           <!-- <xsl:text> (</xsl:text>
                            <xsl:value-of select="str[@name='category']"/>
                            <xsl:text>)</xsl:text>-->
                        </a>
                        
                    </li>
                </xsl:for-each>
            </ul>
            
            <!-- Call pagination -->   
            
           <!-- <xsl:call-template name="paginationLinks">
                <xsl:with-param name="numFound" select="$numFound"/>
                <xsl:with-param name="start" select="$start"/>
                <xsl:with-param name="rows" select="$rows"/>
            </xsl:call-template>-->

              
        </xsl:for-each>
        
    </xsl:template>
    
    <!-- =====================================================================================
        facet list
        ===================================================================================== -->
    
    <xsl:template name="facet-list" xpath-default-namespace="">
        
        <!-- Call solrsearchurl template -->
        <xsl:variable name="solrsearchurl">
            <xsl:call-template name="solrURL">
                <xsl:with-param name="rowstart">0</xsl:with-param>
                <xsl:with-param name="rowend">0</xsl:with-param> <!-- Don't need results, only facets -->
                <xsl:with-param name="searchfields">id</xsl:with-param>
                <xsl:with-param name="facet">true</xsl:with-param>
                <xsl:with-param name="fq"></xsl:with-param>
                <xsl:with-param name="facetfield"><xsl:value-of select="$subpagetype"/></xsl:with-param>
                <xsl:with-param name="other">
                    <xsl:text>&amp;facet.limit=-1</xsl:text>
                    <xsl:text>&amp;facet.mincount=1</xsl:text>
                    <xsl:choose>
                        <xsl:when test="$tagsort = '' or $tagsort = 'index'">
                            <xsl:text>&amp;facet.sort=index</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>&amp;facet.sort=count</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                </xsl:with-param>
                <xsl:with-param name="q">*:*</xsl:with-param>
                <xsl:with-param name="sort">
                    <xsl:choose>
                        <xsl:when test="$sort != ''">
                            <xsl:value-of select="$sort"/>
                        </xsl:when>
                        <xsl:when test="$pagetype = 'browse'">
                            <xsl:text>title_sort</xsl:text>
                        </xsl:when>
                        <xsl:otherwise test="$pagetype = 'search'">
                            <xsl:text>relevance</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose></xsl:with-param>
            </xsl:call-template>
        </xsl:variable>
        
        <!-- uncomment to see the solr url for testing -->
        <!--[[[<a href="{$solrsearchurl}" target="_blank">Solr Search URL</a>]]]-->
        
        <p>
            <h4>Sort by:</h4>
            <xsl:choose>
                <xsl:when test="$tagsort != 'index' and $tagsort != ''">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$siteroot"/>
                            <xsl:text>abstracts/</xsl:text>
                            <xsl:value-of select="$subpagetype"/>
                            <xsl:text>.html?tagsort=index</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Alphabetical</xsl:text>
                    </a>
                </xsl:when>
                <xsl:otherwise><xsl:text>Alphabetical</xsl:text></xsl:otherwise>
            </xsl:choose>
            
            <xsl:text> | </xsl:text>
            <xsl:choose>
                <xsl:when test="$tagsort != 'count'">
                    <a>
                        <xsl:attribute name="href">
                            <xsl:value-of select="$siteroot"/>
                            <xsl:text>abstracts/</xsl:text>
                            <xsl:value-of select="$subpagetype"/>
                            <xsl:text>.html?tagsort=count</xsl:text>
                        </xsl:attribute>
                        <xsl:text>Count</xsl:text>
                    </a>
                </xsl:when>
                <xsl:otherwise><xsl:text>Count</xsl:text></xsl:otherwise>
            </xsl:choose>
            
            
        </p>
        
        
        <!-- Call solr document -->
        <xsl:for-each select="document($solrsearchurl)">
            
            <!-- Search results list with variables for gallery and list -->
           
            <ul>
                <xsl:for-each select="/response/lst[@name='facet_counts']/lst[@name='facet_fields']/lst[1]/int">
                    
                    <li>
                        <a>
                            <xsl:attribute name="href">
                                <xsl:value-of select="$subpagetype"/>
                                <xsl:text>.html</xsl:text>
                                <xsl:text>?q=</xsl:text>
                                <xsl:value-of select="$subpagetype"/>
                                <xsl:text>:"</xsl:text>
                                <xsl:value-of select="encode-for-uri(@name)"/>
                                <xsl:text>"</xsl:text>
                            </xsl:attribute>
                            
                            <!--<xsl:value-of select="@name"/>-->
                            <xsl:choose>
                                <xsl:when test="$subpagetype = 'author' or
                                                $subpagetype = 'keywords' or
                                                $subpagetype = 'topic' or
                                                $subpagetype = 'affiliation'">
                                    <xsl:value-of select="substring-after(@name, '||')"/>
                                </xsl:when>
                                <xsl:otherwise><xsl:value-of select="@name"/></xsl:otherwise>
                            </xsl:choose>
                            <xsl:text> - </xsl:text><xsl:value-of select="."/>
                        </a>

                    </li>
                </xsl:for-each>
            </ul>
            
        </xsl:for-each>
        
    </xsl:template>
    
    <!-- =====================================================================================
        Helper Templates
        ===================================================================================== -->
    
    <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        url builder
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
    
    <xsl:template name="urlbuilder">
        <xsl:param name="sort"><xsl:value-of select="$sort"/></xsl:param>
        <xsl:param name="searchtype"><xsl:value-of select="$searchtype"/></xsl:param>
        <xsl:param name="start"><xsl:value-of select="$start"/></xsl:param>
        <xsl:param name="pagetype"><xsl:value-of select="$pagetype"/></xsl:param>
        <xsl:param name="subpagetype"><xsl:value-of select="$subpagetype"/></xsl:param>
        <xsl:param name="pageid"><xsl:value-of select="$pageid"/></xsl:param>
        <xsl:param name="fq"><xsl:value-of select="$fq"/></xsl:param>
        
        <!-- Build basic URL -->
        <xsl:value-of select="$siteroot"/>
        <xsl:text>abstracts/</xsl:text>
        <xsl:choose>
            <xsl:when test="$pagetype = 'facets'">
                <xsl:value-of select="$subpagetype"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$pagetype"/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>.html</xsl:text>
        
        <!-- variables, show a ? if any search/display variables present -->
        <xsl:if test="($sort != '' or $searchtype != '' or $start != 0 or $fq != '' or $pagetype = 'search') and $pageid = ''">
            <xsl:text>?</xsl:text>
            <xsl:if test="$searchtype != ''">
                <xsl:text>&amp;searchtype=</xsl:text>
                <xsl:value-of select="$searchtype"/>
            </xsl:if>
            <xsl:if test="$sort != ''">
                <xsl:text>&amp;sort=</xsl:text>
                <xsl:value-of select="$sort"/>
            </xsl:if>
            <xsl:if test="$start != 0">
                <xsl:text>&amp;start=</xsl:text>
                <xsl:value-of select="$start"/>
            </xsl:if>
            <xsl:if test="$fq != ''">
                <xsl:text>&amp;fq=</xsl:text>
                <xsl:value-of select="$fq"/>
            </xsl:if>
            <xsl:if test="$q != ''">
                <xsl:text>&amp;q=</xsl:text>
                <xsl:value-of select="$q"/>
            </xsl:if>
        </xsl:if>
           
    </xsl:template>
    
    <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        paginationLinks ||| Constructs links for pagination
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->
    
    <xsl:template name="paginationLinks">
        <xsl:param name="searchTerm"/>
        <xsl:param name="numFound"/>
        <xsl:param name="start"/> <!-- defaults to 0, unless changed in cocoon sitemap -->
        <xsl:param name="rows"/> <!-- defaults to 10, unless changed in cocoon sitemap -->
        <xsl:param name="sort"/>
        
        <xsl:variable name="prev-link">
            
            <xsl:choose>
                <xsl:when test="$start &lt;= 0">
                    <xsl:text>Previous</xsl:text>
                </xsl:when>
                <xsl:otherwise>

                    <a>
                        <xsl:attribute name="href">
                            <xsl:call-template name="urlbuilder">
                                <xsl:with-param name="start"><xsl:value-of select="$start - $rows"/></xsl:with-param>
                            </xsl:call-template>
                            <xsl:if test="$searchTerm">
                                <xsl:text>q=</xsl:text>
                                <xsl:value-of select="$searchTerm"/>
                                <xsl:text>&#38;</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:text>Previous</xsl:text>
                    </a>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <xsl:variable name="next-link">
            <xsl:choose>
                <xsl:when test="$start + $rows &gt;= $numFound">
                    <xsl:text>Next</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <a>
                        <xsl:attribute name="href">
                            <xsl:call-template name="urlbuilder">
                                <xsl:with-param name="start"><xsl:value-of select="$start + $rows"/></xsl:with-param>
                            </xsl:call-template>
                            <xsl:if test="$searchTerm">
                                <xsl:text>q=</xsl:text>
                                <xsl:value-of select="$searchTerm"/>
                                <xsl:text>&#38;</xsl:text>
                            </xsl:if>
                        </xsl:attribute>
                        <xsl:text>Next</xsl:text>
                    </a>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
        <!-- Pagination HTML (do not show if less than 2 pages) -->
        <xsl:choose>
            <xsl:when test="ceiling($numFound div $rows) != 1">
                <div class="pagination"><xsl:copy-of select="$prev-link"/> | Go to page <form class="jumpForm">
                    <input type="text" name="paginationJump" value="{$start div $rows + 1}"
                        class="paginationJump"/>
                    <input type="submit" value="Go" class="paginationJumpBtn submit"/>
                </form> of <xsl:value-of select="ceiling($numFound div $rows)"/> | <xsl:copy-of
                    select="$next-link"/>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="pagination"><p>Showing all results (Page 1 of 1)</p>
                </div>
            </xsl:otherwise>
        </xsl:choose>
        
        <!-- /end Pagination HTML -->
        
    </xsl:template>
    
    <!-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        solrURL ||| Constructs solr search URL
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ -->

    <xsl:template name="solrURL">
        <xsl:param name="rowstart">0</xsl:param>
        <xsl:param name="rowend">10</xsl:param>
        <xsl:param name="searchfields"></xsl:param><!-- kmd -->
        <xsl:param name="facet">false</xsl:param>
        <xsl:param name="facetfield"></xsl:param>
        <xsl:param name="other"></xsl:param>
        <xsl:param name="q">*:*</xsl:param>
        <xsl:param name="fq">*:*</xsl:param>
        <xsl:param name="sort"></xsl:param>

        <xsl:value-of select="$searchroot"/>
        
        <!-- Add sort if not set to default -->
        <xsl:choose>
            <xsl:when test="$sort = 'relevance'"><!-- do nothing to leave as default sort --></xsl:when>
            <xsl:otherwise>
                <xsl:text>&amp;sort=</xsl:text>
                <xsl:value-of select="$sort"></xsl:value-of>
                <xsl:text>+asc</xsl:text>
                <!--<xsl:text>,date+asc</xsl:text>-->
            </xsl:otherwise>
        </xsl:choose>

            <!-- Start and rows -->
                <xsl:text>&amp;start=</xsl:text>
            <xsl:value-of select="$rowstart"></xsl:value-of>
                <xsl:text>&amp;rows=</xsl:text>
                <xsl:value-of select="$rowend"/>
            <!-- Which fields to return -->
                <xsl:text>&amp;fl=</xsl:text>
                <xsl:value-of select="$searchfields"/>
            <!-- faceting options -->
                <xsl:text>&amp;facet=</xsl:text>
                <xsl:value-of select="$facet"/>
                <xsl:text>&amp;facet.field=</xsl:text>
                <xsl:value-of select="$facetfield"/>
            <!-- anything else, passed through the other variable -->
                <xsl:value-of select="$other"/>
            <!-- query -->
            <xsl:text>&amp;q=%28</xsl:text>
            <xsl:value-of select="encode-for-uri($q)"/>
            <xsl:text>%29</xsl:text>
        <!-- filter query -->
        <xsl:if test="$fq != ''">
            <xsl:text>&amp;fq={!tag=dt}</xsl:text>
            <xsl:value-of select="encode-for-uri($fq)"/>
        </xsl:if>
        
    </xsl:template>  
    
</xsl:stylesheet>
