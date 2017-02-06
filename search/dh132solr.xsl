<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:dc="http://purl.org/dc/elements/1.1/">
	<xsl:output indent="yes"/>
	
	<xsl:include href="../stylesheets/xslt/common.xsl"/>
	
	<xsl:variable name="string"></xsl:variable>



	<xsl:template match="/">
		<add>
			<doc>
				<!-- ======================================
					ID
					Multi=NO 
				===========================================-->
				<field name="id">
					<!-- Get the filename -->
					<xsl:variable name="filename" select="tokenize(base-uri(.), '/')[last()]"/>

					<!-- Split the filename using '\.' -->
					<xsl:variable name="filenamepart" select="substring-before($filename, '.xml')"/>

					<!-- Remove the file extension -->
					<xsl:value-of select="$filenamepart"/>
				</field>
				
				<!-- ======================================
					title
					Multi=NO 
				===========================================-->
				<field name="title">
		
							<xsl:choose>
								<xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Plenary'">
									<xsl:value-of select="/TEI/text[1]/body[1]/div[1]/head[1]"/>
								</xsl:when>
								<xsl:when test="/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]">
									<xsl:value-of select="/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/teiCorpus/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]"/>
								</xsl:otherwise>
							</xsl:choose>
				</field>
				
				<!-- ======================================
					title_sort
					Multi=NO   "“‘  |The |A |
				===========================================-->
				<field name="title_sort">
					<xsl:call-template name="normalize_name">
						<xsl:with-param name="string">
							<xsl:choose>
								<xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Plenary'">
									<xsl:value-of select="/TEI/text[1]/body[1]/div[1]/head[1]"/>
								</xsl:when>
								<xsl:when test="/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]">
									<xsl:value-of select="/TEI/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="/teiCorpus/teiHeader[1]/fileDesc[1]/titleStmt[1]/title[1]"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:with-param>
					</xsl:call-template>
				</field>
				
				<!-- ======================================
					date_sort
					Multi=NO 
				===========================================-->
				<field name="date_sort">
					<xsl:choose>
						<xsl:when test="//keywords[@n='status']/term = 'withdrawn'">
							<xsl:text>withdrawn</xsl:text>
						</xsl:when>
						<xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Poster'">
							<xsl:text>2013071715:30:00</xsl:text>
						</xsl:when>
						<xsl:when test="/TEI/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p/date/@when or /teiCorpus/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p/date/@when">
							<xsl:value-of select="(//teiHeader)[1]/fileDesc[1]/sourceDesc[1]/p/date/@when"/>
							<xsl:value-of select="(//teiHeader)[1]/fileDesc[1]/sourceDesc[1]/p/time/@when"/>
						</xsl:when>
						<xsl:otherwise>
						
						</xsl:otherwise>
					</xsl:choose>
				</field>
				
				<!-- ======================================
					date_day
					Multi=NO 
				===========================================-->
				<field name="date_day">
					<xsl:choose>
						<xsl:when test="//keywords[@n='status']/term = 'withdrawn'">
							<xsl:text>Withdrawn</xsl:text>
						</xsl:when>
						<xsl:when test="/TEI/teiHeader[1]/profileDesc[1]/textClass[1]/keywords[@n='category']/term[1] = 'Poster'">
							<xsl:text>July 17, 2013</xsl:text>
						</xsl:when>
						<xsl:when test="/TEI/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p/date/@when or /teiCorpus/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p/date/@when">
							<xsl:variable name="year"><xsl:value-of select="substring((//teiHeader)[1]/fileDesc[1]/sourceDesc[1]/p/date/@when,1,4)"/></xsl:variable>
							<xsl:variable name="month">July</xsl:variable>
							<xsl:variable name="day"><xsl:value-of select="substring((//teiHeader)[1]/fileDesc[1]/sourceDesc[1]/p/date/@when,7,2)"/></xsl:variable>
							
							<xsl:value-of select="$month"/><xsl:text> </xsl:text> <xsl:value-of select="$day"/><xsl:text>, </xsl:text><xsl:value-of select="$year"/>
							 
							
						</xsl:when>
						<xsl:otherwise>
					
						</xsl:otherwise>
					</xsl:choose>
				</field>
				
				<!-- ======================================
					date_time
					Multi=NO 
				===========================================-->
				<field name="date_time">
					<xsl:choose>
						<xsl:when test="//keywords[@n='status']/term = 'withdrawn'">
							<xsl:text></xsl:text>
						</xsl:when>
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
				</field>
				
				<!-- ======================================
					session_type
					Multi=NO 
				===========================================-->
				
				<field name="session_type">
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
				</field>
							
				
				<!-- ======================================
					session
					Multi=NO 
				===========================================-->
				<field name="session">
					<!--<xsl:value-of select="/TEI/teiHeader[1]/fileDesc[1]/sourceDesc[1]/p[@n='session']"/>-->
					<xsl:choose>
						<xsl:when test="//keywords[@n='status']/term = 'withdrawn'">
							<xsl:text></xsl:text>
						</xsl:when>
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
				</field>

				
				<!-- ======================================
					author
					Multi=YES 
				===========================================-->
				<xsl:for-each
					select="/TEI/teiHeader/fileDesc/titleStmt/author">
					<field name="author">
						<xsl:call-template name="normalize_name">
							<xsl:with-param name="string"><xsl:value-of select="name"/></xsl:with-param>
						</xsl:call-template>
						<xsl:text>||</xsl:text>
						<xsl:value-of select="normalize-space(name)"/>
					</field>
				</xsl:for-each>
				
				<xsl:for-each
					select="/teiCorpus/teiHeader/fileDesc/titleStmt/author">
					<field name="author">
						<xsl:call-template name="normalize_name">
							<xsl:with-param name="string"><xsl:value-of select="name"/></xsl:with-param>
						</xsl:call-template>
						<xsl:text>||</xsl:text>
						<xsl:value-of select="name"/>
					</field>
				</xsl:for-each>
				
				<!-- ======================================
					author_list
					Multi=NO 
				===========================================-->
				<xsl:if test="/TEI"><field name="author_list">
					<xsl:for-each select="/TEI/teiHeader/fileDesc/titleStmt/author">
						<xsl:value-of select="normalize-space(name)"/>
						<xsl:if test="position() != last()"><xsl:text>; </xsl:text></xsl:if>
				</xsl:for-each>
				</field></xsl:if>
				
				<xsl:if test="/teiCorpus">
				<field name="author_list">
					<xsl:for-each select="/teiCorpus/teiHeader/fileDesc/titleStmt/author">
						<xsl:value-of select="name"/>
						<xsl:if test="position() != last()"><xsl:text>; </xsl:text></xsl:if>
				</xsl:for-each>
				</field></xsl:if>
				
				<!-- ======================================
					category
					Multi=NO 
				===========================================-->

				<field name="category">
					<xsl:choose>
						<xsl:when test="/TEI/teiHeader/profileDesc/textClass/keywords[@n='category']/term[1]">
							<xsl:value-of select="/TEI/teiHeader/profileDesc/textClass/keywords[@n='category']/term[1]"/>
						</xsl:when>
						<xsl:when test="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='category']/term[1]">
							<xsl:value-of select="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='category']/term[1]"/>
						</xsl:when>
					</xsl:choose>
				</field>
				
				<!-- ======================================
					subcategory
					Multi=NO 
				===========================================-->
				
				<field name="subcategory">
					<xsl:choose>
						<xsl:when test="/TEI/teiHeader/profileDesc/textClass/keywords[@n='subcategory']/term[1]">
							<xsl:value-of select="/TEI/teiHeader/profileDesc/textClass/keywords[@n='subcategory']/term[1]"/>
						</xsl:when>
						<xsl:when test="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='subcategory']/term[1]">
							<xsl:value-of select="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='subcategory']/term[1]"/>
						</xsl:when>
					</xsl:choose>
				</field>
				
				<!-- ======================================
					topic
					Multi=YES 
				===========================================-->
				
				<xsl:if test="/TEI/teiHeader/profileDesc/textClass/keywords[@n='topic']/term[1][normalize-space()]">
				<xsl:for-each select="/TEI/teiHeader/profileDesc/textClass/keywords[@n='topic']/term">
					<field name="topic">
						<xsl:call-template name="normalize_name">
							<xsl:with-param name="string"><xsl:value-of select="normalize-space(.)"/></xsl:with-param>
						</xsl:call-template>
						<xsl:text>||</xsl:text>
						<xsl:value-of select="normalize-space(.)"/>
					</field>
				</xsl:for-each>
				</xsl:if>
				
				<xsl:if test="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='topic']/term[1][normalize-space()]">
				<xsl:for-each select="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='topic']/term">
					<field name="topic">
						<xsl:call-template name="normalize_name">
							<xsl:with-param name="string"><xsl:value-of select="normalize-space(.)"/></xsl:with-param>
						</xsl:call-template>
						<xsl:text>||</xsl:text>
						<xsl:value-of select="normalize-space(.)"/>
					</field>
				</xsl:for-each>
				</xsl:if>
							
				<!-- ======================================
					keywords
					Multi=YES 
				===========================================-->
				
				<xsl:if test="/TEI/teiHeader/profileDesc/textClass/keywords[@n='keywords']/term[1][normalize-space()]">
				<xsl:for-each
					select="/TEI/teiHeader/profileDesc/textClass/keywords[@n='keywords']/term">
					<field name="keywords">
						<xsl:call-template name="normalize_name">
							<xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
						</xsl:call-template>
						<xsl:text>||</xsl:text>
						<xsl:value-of select="."/>
					</field>
				</xsl:for-each>	
				</xsl:if>
				
				<xsl:if test="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='keywords']/term[1][normalize-space()]">
				<xsl:for-each
					select="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='keywords']/term">
					<field name="keywords">
						
							<xsl:call-template name="normalize_name">
								<xsl:with-param name="string"><xsl:value-of select="."/></xsl:with-param>
							</xsl:call-template>
							<xsl:text>||</xsl:text>
						
						<xsl:value-of select="."/>
					</field>
				</xsl:for-each>	
					</xsl:if>
				
				<!-- ======================================
					combo_keywords
					Multi=YES 
					This is a combined, normalized version of the above
				===========================================-->
				
				<xsl:if test="/TEI/teiHeader/profileDesc/textClass/keywords[@n='keywords']/term[1][normalize-space()]">
				<xsl:for-each
					select="/TEI/teiHeader/profileDesc/textClass/keywords[@n='keywords']/term">
					<field name="combo_keywords">
						<xsl:value-of select="normalize-space(lower-case(.))"/>
					</field>
				</xsl:for-each>
				</xsl:if>
				
					<xsl:if test="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='keywords']/term[1][normalize-space()]">
				<xsl:for-each
					select="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='keywords']/term">
					<field name="combo_keywords">
						<xsl:value-of select="normalize-space(lower-case(.))"/>
					</field>
				</xsl:for-each>	
					</xsl:if>
				
					<xsl:if test="/TEI/teiHeader/profileDesc/textClass/keywords[@n='topic']/term[1][normalize-space()]">
				<xsl:for-each select="/TEI/teiHeader/profileDesc/textClass/keywords[@n='topic']/term">
					<field name="combo_keywords">
						<xsl:value-of select="normalize-space(lower-case(.))"/>
					</field>
				</xsl:for-each>
					</xsl:if>
				
					<xsl:if test="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='topic']/term[1][normalize-space()]">
				<xsl:for-each select="/teiCorpus/teiHeader/profileDesc/textClass/keywords[@n='topic']/term">
					<field name="combo_keywords">
						<xsl:value-of select="normalize-space(lower-case(.))"/>
					</field>
				</xsl:for-each>
					</xsl:if>
				
				
				
				
				
				<!-- ======================================
					affiliation
					Multi=YES 
				===========================================-->
				
				<xsl:for-each
					select="/TEI/teiHeader/fileDesc/titleStmt/author">
					<field name="affiliation">
						<xsl:call-template name="normalize_name">
							<xsl:with-param name="string"><xsl:value-of select="affiliation"/></xsl:with-param>
						</xsl:call-template>
						<xsl:text>||</xsl:text>
						<xsl:value-of select="affiliation"/>
					</field>
				</xsl:for-each>
				
				<xsl:for-each
					select="/teiCorpus/teiHeader/fileDesc/titleStmt/author">
					<field name="affiliation">
						<xsl:call-template name="normalize_name">
							<xsl:with-param name="string"><xsl:value-of select="affiliation"/></xsl:with-param>
						</xsl:call-template>
						<xsl:text>||</xsl:text>
						<xsl:value-of select="affiliation"/>
					</field>
				</xsl:for-each>
				
				<!-- ======================================
					text
					Multi=NO 
				===========================================-->

				<field name="text">
					<xsl:value-of select="//text"/>
				</field>
				
				
			</doc>
		</add>

	</xsl:template>

</xsl:stylesheet>
