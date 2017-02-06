<?xml version="1.0"?>
<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns:functx="http://www.functx.com"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xpath-default-namespace="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.w3.org/1999/xhtml" version="2.0">


  <xsl:output method="xhtml" indent="no" encoding="UTF-8"/>
  <xsl:param name="pagetype"></xsl:param>
  <xsl:param name="subpagetype"></xsl:param>
  <xsl:param name="q"></xsl:param>
  <xsl:param name="fq"></xsl:param>
  <xsl:param name="pageid"></xsl:param>
  <xsl:param name="start" as="xs:integer">0</xsl:param>
  <xsl:param name="rows" as="xs:integer">300</xsl:param>

  <xsl:param name="searchtype"></xsl:param>
  <xsl:param name="sort"></xsl:param>
  <xsl:param name="tagsort"></xsl:param>

  <xsl:include href="../../config/config.xsl"/>

  <xsl:include href="common.xsl"/>
  <xsl:include href="page_templates.xsl"/>
  <xsl:include href="html_template.xsl"/>

  <!-- Things to hide -->

  <xsl:template match="revisionDesc | publicationStmt | sourceDesc | figDesc">
    <!-- hide -->
    <xsl:text> </xsl:text>
  </xsl:template>

  <!-- Paragraphs and line breaks, add a rule check for nested paragraphs -->
  
  <xsl:template match="html/body" xpath-default-namespace="">
 
    <xsl:copy-of select="."/>
    
  </xsl:template>

  <xsl:template match="p">
    <xsl:choose>
      <xsl:when test="ancestor::*[name() = 'p']">
        <div class="p">
          <xsl:apply-templates/>
        </div>
      </xsl:when>
      <xsl:otherwise>
        <p>
          <xsl:apply-templates/>
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  

  <xsl:template match="p[@rend='italics']">
    <p>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <em>
        <xsl:apply-templates/>
      </em>
    </p>
  </xsl:template>

  <xsl:template match="lb">
    <xsl:apply-templates/>
    <br/>
  </xsl:template>

  <!-- FW -->
  <xsl:template match="fw">
    <xsl:if test="not(@type='sub')">
      <h6>
        <xsl:attribute name="class">
          <xsl:value-of select="name()"/>
        </xsl:attribute>
        <xsl:apply-templates/>
      </h6>
    </xsl:if>
  </xsl:template>

  <!-- Links -->

  <xsl:template match="xref[@n]">
    <a href="{@n}">
      <xsl:apply-templates/>
    </a>
  </xsl:template>

<!-- TeiHeader / Metadata section -->
  
  <xsl:template match="teiHeader">
    <h3><xsl:value-of select="fileDesc/titleStmt/title[1]"></xsl:value-of></h3>
    <xsl:choose>
      <!-- If withdrawn, show that instead of date and time -->
      <xsl:when test="/TEI/teiHeader/profileDesc/textClass/keywords[@n='status']/term = 'withdrawn'">
        <h4>Withdrawn</h4>
      </xsl:when>
      <xsl:otherwise>
        <xsl:if test="parent::teiCorpus or /TEI">
          <h5>
            <!-- Date and Place -->
            <!-- Day -->
            <xsl:choose>
              <xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Poster'">
                <xsl:text>July 17, 2013, 15:30 | Centennial Room, Nebraska Union</xsl:text>
              </xsl:when>
              <xsl:when test="/TEI/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p/date/@when or /teiCorpus/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p/date/@when">
                <xsl:variable name="year"><xsl:value-of select="substring((//teiHeader)[1]/fileDesc[1]/sourceDesc[1]/p/date/@when,1,4)"/></xsl:variable>
                <xsl:variable name="month">July</xsl:variable>
                <xsl:variable name="day"><xsl:value-of select="substring((//teiHeader)[1]/fileDesc[1]/sourceDesc[1]/p/date/@when,7,2)"/></xsl:variable>
                
                <xsl:value-of select="$month"/><xsl:text> </xsl:text> <xsl:value-of select="$day"/><xsl:text>, </xsl:text><xsl:value-of select="$year"/><xsl:text>, </xsl:text>
                <!-- Time -->
                <xsl:choose>
                  <xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Poster'">
                    <xsl:text>13:30</xsl:text>
                  </xsl:when>
                  <xsl:when test="/TEI/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p/time/@when or /teiCorpus/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p/date/@when">
                    <xsl:variable name="time"><xsl:value-of select="substring((//teiHeader)[1]/fileDesc[1]/sourceDesc[1]/p/time/@when,1,5)"/></xsl:variable>
                    <xsl:value-of select="$time"/>
                  </xsl:when>
                  <xsl:otherwise>
                    
                  </xsl:otherwise>
                </xsl:choose>
                <xsl:text> | </xsl:text>
                <!-- Type -->
                <xsl:choose>
                  <xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Plenary'">
                    <xsl:choose>
                      <xsl:when test="/TEI/@xml:id = 'plenary-001'">
                        <xsl:text>Opening Keynote</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'plenary-002'">
                        <xsl:text>Robert Busa Prize Lecture</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'plenary-003'">
                        <xsl:text>Closing Keynote</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Workshops'">
                    <xsl:text>Workshop</xsl:text>
                  </xsl:when>
                  <xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Poster'">
                    <xsl:text>Poster</xsl:text>
                  </xsl:when>
                  <xsl:when test="/TEI/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p[@n='session'] or 
                    /teiCorpus/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p[@n='session']">
                    <xsl:variable name="session"><xsl:value-of select="//p[@n='session']"/></xsl:variable>
                    <xsl:choose>
                      <xsl:when test="starts-with($session,'LP')"><xsl:text>Long Paper</xsl:text></xsl:when>
                      <xsl:when test="starts-with($session,'SP')"><xsl:text>Short Paper</xsl:text></xsl:when>
                      <xsl:when test="starts-with($session,'PS')"><xsl:text>Panel</xsl:text></xsl:when>
                    </xsl:choose>
                  </xsl:when>
                </xsl:choose>
                <xsl:text>, </xsl:text>
                <!-- Place -->
                <xsl:choose>
                  <xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Plenary'">
                    <xsl:choose>
                      <xsl:when test="/TEI/@xml:id = 'plenary-001'">
                        <xsl:text>Kimball Auditorium</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'plenary-002'">
                        <xsl:text>Kimball Auditorium</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'plenary-003'">
                        <xsl:text>Kimball Auditorium</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Workshops'">
                    <xsl:choose>
                      <xsl:when test="/TEI/@xml:id = 'workshops-001'">
                        <xsl:text>Regency C, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-002'">
                        <xsl:text>Ubuntu, Multicultural Center</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-003'">
                        <xsl:text>Regency A, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-004'">
                        <xsl:text>Regency B, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-005'">
                        <xsl:text>Regency B, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-007'">
                        <xsl:text>Regency A, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-008'">
                        <xsl:text>Ubuntu, Multicultural Center</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-009'">
                        <xsl:text>Regency C, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-010'">
                        <xsl:text>Regency B, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-011'">
                        <xsl:text>Ubuntu, Multicultural Center</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-012'">
                        <xsl:text>Regency A, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-013'">
                        <xsl:text>Regency A, Union</xsl:text>
                      </xsl:when>
                      <xsl:when test="/TEI/@xml:id = 'workshops-014'">
                        <xsl:text>Ubuntu, Multicultural Center</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Poster'">
                    <xsl:text>Centennial Room, Nebraska Union</xsl:text>
                  </xsl:when>
                  <xsl:when test="/TEI/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p[@n='session'] or 
                    /teiCorpus/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p[@n='session']">
                    <xsl:variable name="session"><xsl:value-of select="//p[@n='session']"/></xsl:variable>
                    
                    
                    <xsl:choose>
                      <xsl:when test="$session = 'LP01' or
                        $session = 'LP04' or
                        $session = 'LP07' or
                        $session = 'LP10' or
                        $session = 'LP13' or
                        $session = 'LP16' or
                        $session = 'LP19' or
                        $session = 'LP22' or
                        $session = 'LP25'">
                        <xsl:text>Embassy Regents C</xsl:text>
                      </xsl:when>
                      <xsl:when test="$session = 'LP02' or
                        $session = 'LP05' or
                        $session = 'LP08' or
                        $session = 'LP11' or
                        $session = 'LP14' or
                        $session = 'LP17' or
                        $session = 'LP20' or
                        $session = 'LP23' or
                        $session = 'LP26'">
                        <xsl:text>Embassy Regents D</xsl:text>
                      </xsl:when>
                      <xsl:when test="$session = 'LP03' or
                        $session = 'LP06' or
                        $session = 'LP09' or
                        $session = 'LP12' or
                        $session = 'LP15' or
                        $session = 'LP18' or
                        $session = 'LP21' or
                        $session = 'LP24' or
                        $session = 'LP27' or
                        $session = 'LP03'">
                        <xsl:text>Burnett 115</xsl:text>
                      </xsl:when>
                      <xsl:when test="$session = 'PS01' or 
                        $session = 'PS02' or
                        $session = 'PS03' or 
                        $session = 'PS04' or 
                        $session = 'PS05' or 
                        $session = 'PS06' or 
                        $session = 'PS07' or 
                        $session = 'PS08' or 
                        $session = 'LP28'">
                        <xsl:text>CBA 143</xsl:text>
                      </xsl:when>
                      <xsl:when test="$session = 'SP01' or
                        $session = 'SP03' or
                        $session = 'SP05' or
                        $session = 'SP07' or
                        $session = 'SP09' or
                        $session = 'SP11' or
                        $session = 'SP13' or
                        $session = 'SP15' or
                        $session = 'PS09'">
                        <xsl:text>Embassy Regents E</xsl:text>
                      </xsl:when>
                      <xsl:when test="$session = 'SP02' or
                        $session = 'SP04' or
                        $session = 'SP06' or
                        $session = 'SP08' or
                        $session = 'SP10' or
                        $session = 'SP12' or
                        $session = 'SP14' or
                        $session = 'SP16'">
                        <xsl:text>Embassy Regents F</xsl:text>
                      </xsl:when>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:otherwise>
                    
                  </xsl:otherwise>
                </xsl:choose>
                
                
              </xsl:when>
              <xsl:otherwise>
                
              </xsl:otherwise>
            </xsl:choose> 
            <!-- /Time and Place -->
          </h5>
        </xsl:if>
      </xsl:otherwise>
    </xsl:choose>
    
    
    
    <!-- Testing for author, so as not to repeat metadata section -->
    <xsl:if test="fileDesc/titleStmt/author[1][normalize-space()]">
      
    
    <div class="metadata">
      
      
      <div class="author">
    <xsl:for-each select="fileDesc/titleStmt/author">
      <p span="author">
        <strong>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="$siteroot"/>
              <xsl:text>abstracts/author.html?q=author:"</xsl:text>
              <!--<xsl:value-of select="name"/>-->
              
                
                  <xsl:call-template name="normalize_name">
                    <xsl:with-param name="string">
                      <xsl:value-of select="encode-for-uri(normalize-space(name))"/>
                    </xsl:with-param>
                  </xsl:call-template>
                  <xsl:text>||</xsl:text>
              <xsl:value-of select="encode-for-uri(normalize-space(name))"/>
                
              
              <xsl:text>"</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="name"/>
          </a>
        </strong> | 
        <xsl:value-of select="email"/> | 
        <a>
          <xsl:attribute name="href">
            <xsl:value-of select="$siteroot"/>
            <xsl:text>abstracts/affiliation.html?q=affiliation:"</xsl:text>
            <xsl:call-template name="normalize_name">
              <xsl:with-param name="string"><xsl:value-of select="encode-for-uri(affiliation)"/></xsl:with-param>
            </xsl:call-template>
            <xsl:text>||</xsl:text>
            <xsl:value-of select="encode-for-uri(affiliation)"/>
            <xsl:text>"</xsl:text>
          </xsl:attribute>
          <xsl:value-of select="affiliation"/><xsl:text>&#160;</xsl:text>
        </a>
        
      </p>
      
    </xsl:for-each>
      </div><!-- /author -->
    
    <xsl:if test="profileDesc/textClass/keywords[@n='topic']/term[1][normalize-space()]">
      <div class="keywords">
      <h4>Topic(s):</h4>
      <ul>
      <xsl:for-each select="profileDesc/textClass/keywords[@n='topic']/term">
        <li>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="$siteroot"/>
              <xsl:text>abstracts/topic.html?q=topic:"</xsl:text>
              <xsl:call-template name="normalize_name">
                <xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
              </xsl:call-template>
              <xsl:text>||</xsl:text>
              <xsl:value-of select="encode-for-uri(.)"/>
              <xsl:text>"</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </a>
        </li>
      </xsl:for-each>
      </ul>
      </div>
    </xsl:if>
    
    <xsl:if test="profileDesc/textClass/keywords[@n='keywords']/term[1][normalize-space()]">
      <div class="keywords">
      <h4>Keyword(s):</h4>
      <ul>
      <xsl:for-each select="profileDesc/textClass/keywords[@n='keywords']/term">
        <li>
          <a>
            <xsl:attribute name="href">
              <xsl:value-of select="$siteroot"/>
              <xsl:text>abstracts/keywords.html?q=keywords:"</xsl:text>
              <xsl:variable name="keywords_normalized">
              <xsl:call-template name="normalize_name">
                <xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
              </xsl:call-template></xsl:variable>
              <xsl:value-of select="encode-for-uri($keywords_normalized)"/>
              <xsl:text>||</xsl:text>
              <xsl:value-of select="encode-for-uri(.)"/>
              <xsl:text>"</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="."/>
          </a>
          
        </li>
      </xsl:for-each>
      </ul>
      </div>
    </xsl:if>
      <xsl:if test="parent::*/@xml:id">
      <div class="keywords">
        <h4>Download TEI XML:</h4>
        <!--<xsl:choose>
          <xsl:when test="/teiCorp"></xsl:when>
        </xsl:choose>-->
        
          <ul><li>
            <a>
              <xsl:attribute name="href">
                <xsl:value-of select="parent::*/@xml:id"/>
                  <xsl:text>.xml</xsl:text>
              </xsl:attribute>
              <xsl:value-of select="parent::*/@xml:id"/>
            <xsl:text>.xml</xsl:text>
            </a>

          </li></ul>

      </div>
      </xsl:if>
      
    </div><!-- /metadata -->
    </xsl:if>
  </xsl:template>

<xsl:template match="div[@type='References']">
  <h4>References</h4>
  <xsl:apply-templates/>
</xsl:template>
  
  <xsl:template match="div[@type='Notes']">
    <h4>Notes</h4>
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template
    match="byline | docDate | sp | speaker | letter | 
    notesStmt | titlePart | docDate | ab | trailer | 
    front | lg | l | bibl | dateline | salute | trailer | titlePage | closer">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:choose>
        <xsl:when test="@type='handwritten'">
          <span>
            <xsl:attribute name="class">
              <xsl:text>handwritten</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates/>
          </span>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:text> </xsl:text>
    </div>
  </xsl:template>

  <!-- Special case, if encoding is fixed, can fold into rule above-->

  <xsl:template match="ab[@rend='italics']">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <em>
        <xsl:apply-templates/>
      </em>
    </div>
  </xsl:template>

  <!-- Elements to turn to SPAN's -->

  <xsl:template match="docAuthor | persName | placeName ">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <!-- <xsl:text> </xsl:text> -->
    </span>
  </xsl:template>

  <!-- HEADS -->

  <xsl:template match="head">
    <!-- need to fix for handwritten text -KD -->
    <xsl:choose>
      <xsl:when test="ancestor::*[name() = 'p']">
        <span class="head">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:when test="ancestor::*[name() = 'figure']">
        <span class="head">
          <xsl:apply-templates/>
        </span>
      </xsl:when>
      <xsl:when test=".[@type='sub']">
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:when>
      <xsl:when test="preceding::*[name() = 'head']">
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:when>
      <xsl:otherwise>
        <h4>
          <xsl:apply-templates/>
        </h4>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- Gaps, Additions, Deletes, Unclear -->

  <xsl:template match="damage">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@type"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text>[?]</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="gap">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@reason"/>
      </xsl:attribute>
      <xsl:apply-templates/>
      <xsl:text>[</xsl:text>
      <xsl:value-of select="@reason"/>
      <xsl:text>]</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="unclear">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@reason"/>
      </xsl:attribute>
      <xsl:text>[</xsl:text>
      <xsl:apply-templates/>
      <xsl:text>?]</xsl:text>
    </span>
  </xsl:template>

  <xsl:template match="del">
    <xsl:choose>
      <xsl:when test="@type='overwrite'">
        <!-- Don't show overwritten text -->
      </xsl:when>
      <xsl:otherwise>
        <del>
          <xsl:attribute name="class">
            <xsl:value-of select="@reason"/>
            <xsl:apply-templates/>
          </xsl:attribute>
          <xsl:value-of select="."/>
          <!-- <xsl:text>[?]</xsl:text> -->
        </del>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="add">
    <xsl:choose>
      <xsl:when test="@place='superlinear' or @place='supralinear'">
        <sup>
          <xsl:apply-templates/>
        </sup>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates/>
      </xsl:otherwise>
    </xsl:choose>


  </xsl:template>

  <!-- Sic's and corrections -->

  <xsl:template match="choice[child::corr]">
    <a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>sic</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="corr"/>​ </xsl:attribute><xsl:apply-templates select="sic"
      /></a>​</xsl:template>

  <!-- orig and reg -->

  <xsl:template match="choice[child::orig]">
    <!-- Hidden because it breaks over pagebreaks -->
    <!--<a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>orig</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="reg"/>​ </xsl:attribute><xsl:apply-templates select="orig"
      /></a>​-->
    <xsl:apply-templates select="orig"/>
  </xsl:template>

  <!-- abbr and expan -->

  <xsl:template match="choice[child::abbr]">
    <a>
      <xsl:attribute name="rel">
        <xsl:text>tooltip</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="class">
        <xsl:text>abbr</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="title">
        <xsl:apply-templates select="expan"/>​ </xsl:attribute><xsl:apply-templates select="abbr"
      /></a>​</xsl:template>
  
  <!-- Figures-->
  
  <xsl:template match="figure">
    <img>
      <xsl:attribute name="src">
        <xsl:value-of select="$siteroot"/>
          <xsl:text>files/figures/large/</xsl:text>
          <xsl:value-of select="graphic/@url"/>
        <xsl:text>.jpg</xsl:text>
      </xsl:attribute>
      
    </img>
    <xsl:if test="p or head">
    <p><em><xsl:value-of select="head"/>
    <xsl:if test="p">
      <br/><xsl:value-of select="p"></xsl:value-of>
    </xsl:if></em></p></xsl:if>
    
  </xsl:template>

 

  <!-- Div types for styling -->

  <xsl:template match="div1 | div2">
    <xsl:choose>
      <xsl:when test="@type='html'">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <div>
          <xsl:attribute name="class">
            <xsl:value-of select="@type"/>

            <xsl:attribute name="class">
              <xsl:if test="preceding-sibling::div1">
                <xsl:text> doublespace</xsl:text>
              </xsl:if>
              <xsl:text> </xsl:text>
              <xsl:value-of select="@subtype"/>
            </xsl:attribute>

          </xsl:attribute>

          <xsl:if test="@corresp">
            <xsl:attribute name="id">
              <xsl:value-of select="substring-after(@corresp, '#')"/>
            </xsl:attribute>
          </xsl:if>

          <xsl:apply-templates/>

        </div>
      </xsl:otherwise>
    </xsl:choose>


  </xsl:template>

  <!-- Handwritten -->
  <xsl:template match="seg[@type='handwritten']">
    <span>
      <xsl:attribute name="class">
        <xsl:text>handwritten</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="div2[@subtype='handwritten']">
    <div>
      <xsl:attribute name="class">
        <xsl:text>handwritten</xsl:text>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>


  <!-- Milestone / horizontal rule -->

  <xsl:template match="milestone">
    <div>
      <xsl:attribute name="class">
        <xsl:text>milestone </xsl:text>
        <xsl:value-of select="@unit"/>
      </xsl:attribute>
      <xsl:text> </xsl:text>
    </div>
  </xsl:template>

  <!-- Notes / Footnotes / references -->


  <xsl:template match="note">
    <xsl:choose>
      <xsl:when test="parent::div[@type='Notes']">
        <p>
          <xsl:attribute name="class"><xsl:text>notes</xsl:text></xsl:attribute>
          <xsl:attribute name="id">
            <xsl:text>note</xsl:text>
            <xsl:value-of select="@xml:id"/>
          </xsl:attribute>
          <xsl:value-of select="@n"/><xsl:text>. </xsl:text>
          <xsl:apply-templates/>
        </p>
      </xsl:when>
      <xsl:when test="@place='foot'">
        <span>
          <xsl:attribute name="class">
            <xsl:text>foot</xsl:text>
          </xsl:attribute>
          <a>
            <xsl:attribute name="href">
              <xsl:text>#</xsl:text>
              <xsl:text>foot</xsl:text>
              <xsl:value-of select="@xml:id"/>
            </xsl:attribute>
            <xsl:attribute name="id">
              <xsl:text>body</xsl:text>
              <xsl:value-of select="@xml:id"/>
            </xsl:attribute>

            <xsl:text>(</xsl:text>
            <xsl:value-of select="substring(@xml:id, 2)"/>
            <xsl:text>)</xsl:text>
          </a>
        </span>
      </xsl:when>
      <xsl:when test="@type='editorial'"/>
      <xsl:otherwise>
        <div>
          <xsl:attribute name="class">
            <xsl:value-of select="name()"/>
          </xsl:attribute>
          <xsl:apply-templates/>
        </div>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <xsl:template match="ref">
    <xsl:choose>
      <!-- Link to footnote -->
      <xsl:when test="starts-with(@target, 'n') or starts-with(@target, 'p') ">
        <xsl:variable name="n" select="@target"/>
        <xsl:text> [</xsl:text><a>
          <xsl:attribute name="id">
            <xsl:text>ref</xsl:text>
            <xsl:value-of select="@target"/>
          </xsl:attribute>
          <xsl:attribute name="class">
            <xsl:text>inlinenote</xsl:text>
          </xsl:attribute>
          <xsl:attribute name="href">
            <xsl:text>#note</xsl:text>
            <xsl:value-of select="@target"/>
          </xsl:attribute>
          <xsl:text></xsl:text>
          <xsl:apply-templates/>
          <xsl:text></xsl:text>
        </a><xsl:text>] </xsl:text>
      </xsl:when>
      <!-- URL -->
      <xsl:when test="@type='link'">
        <a href="{@target}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:when test="@type='url'">
        <a href="{@target}">
          <xsl:apply-templates/>
        </a>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text> </xsl:text>
        <a href="{@target}" id="{@target}.ref" class="footnote">

          <xsl:choose>
            <xsl:when test="descendant::text()">
              <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@n"/>
            </xsl:otherwise>
          </xsl:choose>

        </a>
        <xsl:text> </xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>


  <!-- Rules for em tag -->

  <xsl:template
    match="term | foreign | emph | title[not(@level='a')] | biblScope[@type='volume'] | 
    hi[@rend='italic'] | hi[@rend='italics']">
    <em>
      <xsl:apply-templates/>
    </em>
  </xsl:template>

  <xsl:template match="hi[@rend='underlined']">
    <u>
      <xsl:apply-templates/>
    </u>
  </xsl:template>

  <!-- Things that should be strong -->

  <xsl:template match="item/label">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

  <xsl:template match="hi[@rend='bold']">
    <strong>
      <xsl:apply-templates/>
    </strong>
  </xsl:template>

  <!-- Rules to account for hi tags other than em and strong-->

  <xsl:template match="hi[@rend='underline']">
    <u>
      <xsl:apply-templates/>
    </u>
  </xsl:template>

  <xsl:template match="hi[@rend='quoted']">
    <xsl:text>"</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>"</xsl:text>
  </xsl:template>

  <xsl:template match="hi[@rend='super'] | hi[@rend='sup'] | hi[@rend='superscript']">
    <sup>
      <xsl:apply-templates/>
    </sup>
  </xsl:template>

  <xsl:template match="hi[@rend='subscript'] | hi[@rend='sub']">
    <sub>
      <xsl:apply-templates/>
    </sub>
  </xsl:template>

  <xsl:template match="hi[@rend='smallcaps'] | hi[@rend='roman']">
    <span>
      <xsl:attribute name="class">
        <xsl:value-of select="@rend"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

  <xsl:template match="hi[@rend='right'] | hi[@rend='center']">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="@rend"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </div>
  </xsl:template>

  <!-- Signed -->
  <xsl:template match="//signed">
    <br/>
    <xsl:apply-templates/>
  </xsl:template>

  <!-- Table Rules -->

  <xsl:template match="table">
    <xsl:choose>
      <xsl:when test="@rend='handwritten'">
        <table>
          <xsl:attribute name="class">
            <xsl:text>handwritten</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </table>
      </xsl:when>
      <xsl:otherwise>
        <table>
          <xsl:apply-templates/>
        </table>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="row">
    <tr>
      <xsl:apply-templates/>
    </tr>
  </xsl:template>

  <xsl:template match="cell">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <!-- Lists -->

  <xsl:template match="list">
    <xsl:choose>
       <xsl:when test="@type='unordered'">
        <ul>
          <xsl:attribute name="class">
            <xsl:text>unordered</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </ul>
      </xsl:when>
      <xsl:when test="@type='ordered'">
        <ul>
          <xsl:attribute name="class">
            <xsl:text>ordered</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </ul>
      </xsl:when>
      <xsl:when test="@type='simple'">
        <ul>
          <xsl:attribute name="class">
            <xsl:text>simple</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </ul>
      </xsl:when>
     <!-- <xsl:when test="@type='handwritten'">
        <ul>
          <xsl:attribute name="class">
            <xsl:text>handwritten</xsl:text>
          </xsl:attribute>
          <xsl:apply-templates/>
        </ul>
      </xsl:when>-->
      <xsl:otherwise>
        <ul>
          <xsl:apply-templates/>
        </ul>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <!-- Space -->

  <xsl:template match="space">
    <span class="teispace">
      <xsl:text>[no handwritten text supplied here]</xsl:text>
    </span>
  </xsl:template>

  <!-- Quotes -->

  <xsl:template match="q | quote">
    <blockquote>
      <p>
        <xsl:apply-templates/>
      </p>
    </blockquote>
  </xsl:template>
  
  <xsl:template name="normalize_name">
    <xsl:param name="string"/>
    
    <xsl:variable name="string_lower"><xsl:value-of select="normalize-space(translate(lower-case($string), '“‘&quot;', ''))"/></xsl:variable>
    
    <xsl:choose>
      <xsl:when test="starts-with($string_lower, 'a ')">
        <xsl:value-of select="substring-after($string_lower, 'a ')"></xsl:value-of>
      </xsl:when>
      <xsl:when test="starts-with($string_lower, 'the ')">
        <xsl:value-of select="substring-after($string_lower, 'the ')"></xsl:value-of>
      </xsl:when>
      <xsl:when test="starts-with($string_lower, 'an ')">
        <xsl:value-of select="substring-after($string_lower, 'an ')"></xsl:value-of>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string_lower"></xsl:value-of>
      </xsl:otherwise>
    </xsl:choose>
    
    
  </xsl:template>

</xsl:stylesheet>
