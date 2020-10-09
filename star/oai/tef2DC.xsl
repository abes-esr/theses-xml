<?xml version="1.0" encoding="UTF-8"?>
<!--
-->
<xsl:stylesheet
 version="1.0"
 xmlns:tef="http://www.abes.fr/abes/documents/tef"
 xmlns:dc="http://purl.org/dc/elements/1.1/"
 xmlns:mads="http://www.loc.gov/mads/"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:dcterms="http://purl.org/dc/terms/"
 xmlns:mets="http://www.loc.gov/METS/"
 xmlns:metsRights="http://cosimo.stanford.edu/sdr/metsrights/"
 xmlns:xlink="http://www.w3.org/1999/xlink"
 xmlns:date="http://exslt.org/dates-and-times" 
 exclude-result-prefixes="dcterms mads mets metsRights tef"
 >

 <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

 <xsl:param name="g_dateToday" select='2008-11-18'/>

 <xsl:template match="/mets:mets">
   <oai_dc:dc
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation
      ="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd"
    >
   <xsl:for-each select="//tef:thesisRecord/dc:title">
    <dc:title>
     <xsl:attribute name="xml:lang">
      <xsl:value-of select="@xml:lang" />
     </xsl:attribute>
     <xsl:value-of select="."/>
    </dc:title>
   </xsl:for-each>

   <xsl:for-each select="//tef:thesisRecord/dcterms:alternative">
    <dc:title>
     <xsl:attribute name="xml:lang">
      <xsl:value-of select="@xml:lang" />
     </xsl:attribute>
     <xsl:value-of select="."/>
    </dc:title>
   </xsl:for-each>

   <xsl:for-each select="//tef:thesisRecord/dc:subject">
    <dc:subject>
     <xsl:attribute name="xml:lang">
      <xsl:value-of select="@xml:lang" />
     </xsl:attribute>
     <xsl:value-of select="."/>
    </dc:subject>
   </xsl:for-each>

   <xsl:for-each select="//tef:thesisRecord/dcterms:abstract">
    <dc:description>
     <xsl:attribute name="xml:lang">
      <xsl:value-of select="@xml:lang" />
     </xsl:attribute>
     <xsl:value-of select="."/>
    </dc:description>
   </xsl:for-each>

   <xsl:for-each select="//tef:thesisRecord/dc:type">
    <dc:type>
     <!--
     <xsl:attribute name="xsi:type">
      <xsl:value-of select="@xsi:type" />
     </xsl:attribute>
     -->
     <xsl:value-of select="."/>
    </dc:type>
   </xsl:for-each>

   <xsl:for-each select="//tef:thesisRecord/dc:language">
    <dc:language>
     <!--
     <xsl:attribute name="xsi:type">
      <xsl:value-of select="@xsi:type" />
     </xsl:attribute>
     -->
     <xsl:value-of select="."/>
    </dc:language>
   </xsl:for-each>

   <xsl:for-each select="//tef:thesisRecord/dcterms:spatial">
    <dc:coverage>
     <xsl:attribute name="xml:lang">
      <xsl:value-of select="@xml:lang" />
     </xsl:attribute>
     <xsl:value-of select="."/>
    </dc:coverage>
   </xsl:for-each>

   <xsl:for-each select="//tef:thesisRecord/dcterms:temporal">
    <dc:coverage>
     <xsl:attribute name="xml:lang">
      <xsl:value-of select="@xml:lang" />
     </xsl:attribute>
     <xsl:value-of select="."/>
    </dc:coverage>
   </xsl:for-each>
   <!-- -->
   <!--
    on cherche les URLs des éditions dont les versions ont
     des droits qui permettent la diffusion.
    Après [ @DISPLAY='true' ] il faudrait aussi gérer la période
     de confidentialité.
      mets:mdWrap[ @OTHERMDTYPE='tef_droits_version' ]
                    /mets:xmlData/metsRights:RightsDeclarationMD
                     /metsRights:Context/metsRights:Constraints
                      [ @CONSTRAINTTYPE='TIME' ]
                      /metsRights:ConstraintDescription
   -->
   <!--
   <xsl:text>!</xsl:text>
   <xsl:value-of
    select=
      "substring-after
       (normalize-space
        (substring-after
         (normalize-space
          (/mets:mets/mets:amdSec/mets:rightsMD
           /mets:mdWrap[ @OTHERMDTYPE='tef_droits_version' ]
           /mets:xmlData/metsRights:RightsDeclarationMD
            /metsRights:Context/metsRights:Constraints
             [ @CONSTRAINTTYPE='TIME' ]
             /metsRights:ConstraintDescription
          )
         , ' '
         )
        )
       , ' '
       )
      "
   />
   <xsl:text>!</xsl:text>
   -->
   <!--
    and
                    (substring-after
                     (normalize-space
                      (substring-after
                       (normalize-space
                        (mets:mdWrap[ @OTHERMDTYPE='tef_droits_version' ]
                         /mets:xmlData/metsRights:RightsDeclarationMD
                          /metsRights:Context/metsRights:Constraints
                           [ @CONSTRAINTTYPE='TIME' ]
                           /metsRights:ConstraintDescription
                        )
                       , ' '
                       )
                      )
                     , ' '
                     )
                    )&lt;$g_dateToday
   -->
 
     <xsl:variable name="scenario"><xsl:value-of select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/@scenario"/></xsl:variable>
     <xsl:if test="$scenario = 'cas5' or $scenario = 'cas6'">
        <dc:identifier>
         <xsl:value-of select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@urlPerenne"/>
      </dc:identifier>
     </xsl:if> 
    

    <xsl:if test="$scenario = 'cas1' or $scenario = 'cas2' or $scenario = 'cas3' or $scenario = 'cas4'">
             <xsl:variable name="restriction">
              <xsl:value-of select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@restrictionTemporelleType"/>
             </xsl:variable>
     
             <xsl:if test="$restriction = 'sansObjet'">
                      <dc:identifier>
                       <xsl:value-of select="concat(/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@urlPerenne, '/document')"/>
                      </dc:identifier>
             </xsl:if>
     
              <xsl:if test="$restriction = 'embargo' or $restriction = 'confidentialite' or $restriction = 'confEmbargo'">
                         <xsl:variable name="now" select="translate(date:date(), '-', '')"/>
                         <xsl:variable name="finRestriction"><xsl:value-of select="translate(/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@restrictionTemporelleFin, '-', '')"/></xsl:variable>
                         <xsl:if test="$finRestriction='' or ($finRestriction &lt; $now)">
                                   <dc:identifier>
                                    <xsl:value-of select="concat(/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@urlPerenne, '/document')"/>
                                   </dc:identifier>
                         </xsl:if>
                         <xsl:if test="$finRestriction &gt; $now">
                                   <dc:identifier>
                                    <xsl:value-of select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@urlPerenne"/>
                                   </dc:identifier>
                         </xsl:if>
              </xsl:if>
    </xsl:if> 

   <xsl:for-each select="//tef:thesisAdmin">
    <dc:creator>
     <xsl:value-of select="tef:auteur/tef:nom"/>
     <xsl:text>, </xsl:text>
     <xsl:value-of select="tef:auteur/tef:prenom"/>
    </dc:creator>
    <dc:date>
     <xsl:value-of select="dcterms:dateAccepted"/>
    </dc:date>
    <xsl:for-each select="tef:thesis.degree/tef:thesis.degree.grantor">
     <dc:contributor>
      <xsl:value-of select="tef:nom"/>
     </dc:contributor>
    </xsl:for-each>
    <xsl:for-each select="tef:directeurThese">
     <dc:contributor>
      <xsl:value-of select="tef:nom"/>
      <xsl:text>, </xsl:text>
      <xsl:value-of select="tef:prenom"/>
     </dc:contributor>
    </xsl:for-each>
   </xsl:for-each>

   <!--



   -->

   <!--


   -->


    </oai_dc:dc>
  </xsl:template>

</xsl:stylesheet>
