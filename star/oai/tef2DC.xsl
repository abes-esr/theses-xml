<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:tef="http://www.abes.fr/abes/documents/tef"
    xmlns:tefextension="http://www.abes.fr/abes/documents/tefextension"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:mads="http://www.loc.gov/mads/"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:mets="http://www.loc.gov/METS/"
    xmlns:metsRights="http://cosimo.stanford.edu/sdr/metsrights/"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:date="http://exslt.org/dates-and-times"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="dcterms mads mets metsRights tef tefextension xs">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <!--  <xsl:param name="g_dateToday" select="2008 - 11 - 18"/>-->
    <xsl:variable name="now" select="current-date()"/>
    <xsl:variable name="restrictionTempType"
        select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@restrictionTemporelleType"/>
    <xsl:variable name="diffusionType"
        select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@typeDiffusion"/>
    <xsl:variable name="finRestriction"
        select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@restrictionTemporelleFin"/>
    <xsl:variable name="embargoFin"
        select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@embargoFin"/>
    <xsl:variable name="confidentialiteFin"
        select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@confidentialiteFin"/>
    <xsl:template match="/mets:mets">
        <oai_dc:dc xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
            xmlns:dc="http://purl.org/dc/elements/1.1/"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd">
            <xsl:for-each select="//tef:thesisRecord/dc:title">
                <dc:title>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="@xml:lang"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </dc:title>
            </xsl:for-each>
            <xsl:for-each select="//tef:thesisRecord/dcterms:alternative">
                <dc:title>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="@xml:lang"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </dc:title>
            </xsl:for-each>
            <xsl:for-each select="//tef:thesisRecord/dc:subject[@xml:lang]">
                <dc:subject>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="@xml:lang" />
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </dc:subject>
            </xsl:for-each>
            
            <xsl:for-each select="//tef:thesisRecord/dc:subject[@xsi:type='dcterms:DDC']">
                <dc:subject>      
                    <xsl:attribute name="xsi:type">
                        <xsl:text>dcterms:DDC</xsl:text>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </dc:subject>
            </xsl:for-each>
            <xsl:for-each select="//tef:thesisRecord/dcterms:abstract">
                <dc:description>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="@xml:lang"/>
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
                        <xsl:value-of select="@xml:lang"/>
                    </xsl:attribute>
                    <xsl:value-of select="."/>
                </dc:coverage>
            </xsl:for-each>
            <xsl:for-each select="//tef:thesisRecord/dcterms:temporal">
                <dc:coverage>
                    <xsl:attribute name="xml:lang">
                        <xsl:value-of select="@xml:lang"/>
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
            <xsl:variable name="scenario">
                <xsl:value-of
                    select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/@scenario"
                />
            </xsl:variable>
            <xsl:if test="$scenario = 'cas5' or $scenario = 'cas6'">
                <dc:identifier>
                    <xsl:value-of
                        select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@urlPerenne"
                    />
                </dc:identifier>
            </xsl:if>
            <xsl:if
                test="$scenario = 'cas1' or $scenario = 'cas2' or $scenario = 'cas3' or $scenario = 'cas4'">
                <xsl:if test="$restrictionTempType = 'sansObjet'">
                    <dc:identifier>
                        <xsl:value-of
                            select="concat(/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@urlPerenne, '/document')"
                        />
                    </dc:identifier>
                </xsl:if>
                <xsl:if
                    test="$restrictionTempType = 'embargo' or $restrictionTempType = 'confidentialite' or $restrictionTempType = 'confEmbargo'">
                    <!--Chagement xsl 1.0-\->xsl 2.0 : current-date-->
                    <xsl:if test="$finRestriction = '' or $finRestriction &lt; $now">
                        <dc:identifier>
                            <xsl:value-of
                                select="concat(/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@urlPerenne, '/document')"
                            />
                        </dc:identifier>
                    </xsl:if>
                    <xsl:if test="$finRestriction &gt; $now">
                        <dc:identifier>
                            <xsl:value-of
                                select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/sorties/diffusion/@urlPerenne"
                            />
                        </dc:identifier>
                    </xsl:if>
                </xsl:if>
            </xsl:if>
            <xsl:variable name="cas">
                <xsl:value-of
                    select="/mets:mets/mets:dmdSec/mets:mdWrap/mets:xmlData/star_gestion/traitements/@scenario"
                />
            </xsl:variable>
            <!--Pour les DCRights, on teste les dates de restrictionTemporelle et ensuie, en fonction du type de diffusion (Internet/intranet) on statue sur le cas de figure : OpenAccess,RestrictedAccess, ou Confidentielle-->
            <!--1/« Open Access » : diffusion sur Internet
2/ « Restricted access » : diffusion sur IntrAnet
3/ « Restricted access until DATE » : pour les thèses sous embargo, à la fin de celui-ci passent en un des 2 cas ci-dessus. *
4/ « No access until DATE » : pour les thèses confidentielles, à la fin de celui-ci passent en un des 3 cas ci-dessus.*
5/ Quid des conf+embargo ?* : comme le 4/


*pour connaître le type de restriction temporelle :
•	SGrestrTmpTypeDif : peut être embargo/confidentialité/confembargo (=confidentialité+embargo)
•	SGrestrTmpFinDif : donne la date de fin de restriction temporelle, en cas de confidentialité+embargo, donne la plus éloignée (ex. id STAR 121083)

-->
            <!--Si confEmbargo : jusqu'à la fin de la confidentialité statut confidentiel puis régit par embargo ie restriction jsq fin embargo-->
            <xsl:variable name="restrictionTempType">
                <xsl:choose>
                    <xsl:when test="$restrictionTempType = 'confEmbargo'">
                        <xsl:choose>
                            <xsl:when test="$confidentialiteFin &gt; $now">
                                <xsl:text>confidentialite</xsl:text>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:text>embargo</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$restrictionTempType"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:choose>
                <xsl:when
                    test="$restrictionTempType = 'confidentialite' and $confidentialiteFin &gt; $now">
                    <xsl:call-template name="dcRights">
                        <xsl:with-param name="rights" select="'confidentiel'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:when test="$restrictionTempType = 'embargo' and $finRestriction &gt;= $now">
                    <xsl:call-template name="dcRights">
                        <xsl:with-param name="rights" select="'intranet'"/>
                    </xsl:call-template>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:choose>
                        <xsl:when test="$diffusionType = 'internet'">
                            <xsl:call-template name="dcRights">
                                <xsl:with-param name="rights" select="'internet'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:call-template name="dcRights">
                                <xsl:with-param name="rights" select="'intranet'"/>
                            </xsl:call-template>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:for-each select="//tef:thesisAdmin">
                <dc:creator>
                    <xsl:value-of select="tef:auteur/tef:nom"/>
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="tef:auteur/tef:prenom"/>
                </dc:creator>
                <xsl:for-each select="tefextension:coAuteur">
                    <dc:creator>
                        <xsl:value-of select="tef:nom"/>
                        <xsl:text>, </xsl:text>
                        <xsl:value-of select="tef:prenom"/>
                    </dc:creator>
                </xsl:for-each>
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
        </oai_dc:dc>
    </xsl:template>
    <xsl:template name="dcRights">
        <xsl:param name="rights"/>
        <xsl:choose>
            <xsl:when test="$rights = 'internet'">
                <dc:rights>
                    <xsl:text>Open Access</xsl:text>
                </dc:rights>
                <dc:rights>
                    <xsl:text>http://purl.org/eprint/accessRights/OpenAccess</xsl:text>
                </dc:rights>
            </xsl:when>
            <xsl:when test="$rights = 'intranet'">
                <dc:rights>
                    <xsl:text>Restricted Access</xsl:text>
                    <xsl:if test="$finRestriction &gt; $now">
                        <xsl:text> until : </xsl:text>
                        <xsl:value-of select="$embargoFin"/>
                    </xsl:if>
                </dc:rights>
                <dc:rights>
                    <xsl:text>http://purl.org/eprint/accessRights/RestrictedAccess</xsl:text>
                </dc:rights>
            </xsl:when>
            <xsl:when test="$rights = 'confidentiel'">
                <dc:rights>
                    <xsl:text>Confidential until : </xsl:text>
                    <xsl:value-of select="$confidentialiteFin"/>
                </dc:rights>
                <dc:rights>
                    <xsl:text>http://theses.fr/Confidential</xsl:text>
                </dc:rights>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>
