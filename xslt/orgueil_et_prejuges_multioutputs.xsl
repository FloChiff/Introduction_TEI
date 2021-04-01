<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs tei" xmlns="http://www.tei-c.org/ns/1.0" 
    version="2.0">
    <xsl:output method="html" indent="yes" encoding="UTF-8"/>
    
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <xsl:variable name="witfile">
            <xsl:value-of select="replace(base-uri(.), '.xml', '_')"/>
            <!-- récupération du nom et du chemin du fichier courant -->
        </xsl:variable>
        
        <xsl:variable name="pathTranscript">
            <xsl:value-of select="concat($witfile,'transcript','.html')"/>
            <!-- Création d'une page HTML qui reprendra le nom du fichier XML comme défini dans la variable précédente -->
        </xsl:variable>
        <xsl:variable name="pathIndex">
            <xsl:value-of select="concat($witfile,'index','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathMetadonnees">
            <xsl:value-of select="concat($witfile,'metadonnees','.html')"/>
        </xsl:variable>
        <xsl:variable name="pathAccueil">
            <xsl:value-of select="concat($witfile, 'accueil','.html')"/>
        </xsl:variable>
        <xsl:result-document href="{$pathAccueil}"
            method="html" indent="yes">
            <!-- Appel de la page HTML défini en variable précédemment et création d'un nouveau fichier HTML 
                par le biais de <xsl:result-document> qui permet la transformation en plusieurs fichiers -->
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select="//titleStmt/title[@type='main']"/>
                        <!-- Appel de la valeur exacte contenu dans le chemin XPath défini ci-dessus -->
                    </title>
                </head>
                <body>
                    <h1><xsl:value-of select="//titleStmt/title[@type='main']"/></h1>
                    <ul>
                        <li><a href="{$pathMetadonnees}">Métadonnées</a></li>
                        <li><a href="{$pathIndex}">Index des entités</a></li>
                        <li><a href="{$pathTranscript}">Transcriptions</a></li>
                    </ul>
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="{$pathIndex}"
            method="html" indent="yes">      
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select="//titleStmt/title[@type='main']"/>
                    </title>
                </head>
                <body>
                    <h1><xsl:value-of select="//titleStmt/title[@type='main']"/></h1>
                    <span>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </span>
                    <h2>Index</h2>
                    <div>
                        <h3>Index des personnes</h3>
                        <div>
                            <xsl:call-template name="person"/>
                        </div>
                    </div>
                    <div>
                        <h3>Index de lieux</h3>
                        <div>
                            <xsl:call-template name="place"/>
                        </div>
                    </div>    
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document href="{$pathTranscript}" method="html" indent="yes">
            <html>
                <head>
                    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                    <title>
                        <xsl:value-of select="//titleStmt/title[@type='main']"/>
                    </title>
                </head>
                <body>
                    <h1><xsl:value-of select="//titleStmt/title[@type='main']"/></h1>
                    <span>
                        <a href="{$pathAccueil}">Retour accueil</a>
                    </span>
                    <div>
                        <a href="https://gallica.bnf.fr/ark:/12148/bpt6k851387f/f120.double.r=orgueil%20et%20prejuges" target="_blank">Lien vers le manuscrit</a>
                    </div>
                    <div>
                        <h2>Transcriptions</h2>
                        <div>
                            <h3>Ancien français</h3>
                            <p>
                                <xsl:apply-templates select="//text//div[@type='transcription']/div[@type='traduction']/p" mode="orig"/>
                            </p>
                        </div>
                        <div>
                            <h3>Français moderne</h3>
                            <p>
                                <xsl:apply-templates select="//text//div[@type='transcription']/div[@type='traduction']/p" mode="reg"/>
                            </p>
                        </div></div>
                </body>
            </html>
        </xsl:result-document>
    <xsl:result-document href="{$pathMetadonnees}" method="html" indent="yes">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title>
                    <xsl:value-of select="//titleStmt/title[@type='main']"/>
                </title>
            </head>
            <body>
                <h1><xsl:value-of select="//titleStmt/title[@type='main']"/></h1>
                <span>
                    <a href="{$pathAccueil}">Retour accueil</a>
                </span>
                <div>
                    <h2>Métadonnées</h2>
                    <div>
                        <h3>Informations textuelles</h3>
                        <li>Auteur: <xsl:value-of select="//titleStmt/author"/></li>
                        <li>Date originale du texte: <xsl:value-of select="//creation/@when"/></li>
                        <li>Publication: <xsl:apply-templates select="//publicationStmt"></xsl:apply-templates></li>
                        <li>Lieu de conservation: <xsl:apply-templates select="//msIdentifier"/></li>
                        <li>Langue du texte: <xsl:apply-templates select="//langUsage"/>
                        </li>
                    </div>
                    <div>
                        <h3>Informations d'encodage</h3>
                        <li><xsl:apply-templates select="//projectDesc"/></li>
                        <li><xsl:apply-templates select="//correction"/></li>
                        <li><xsl:apply-templates select="//hyphenation"/></li>
                    </div></div>
            </body>
        </html>
    </xsl:result-document>
    </xsl:template>
    
    <xsl:template match="choice" mode="orig">
        <xsl:value-of select="orig/text()"/>
    </xsl:template>
    <xsl:template match="choice" mode="reg">
        <xsl:value-of select="reg/text()"/>
    </xsl:template>
    
    <xsl:template name="place">
        <xsl:for-each select="//listPlace/place">
            <xsl:sort/>
            <li>
                <xsl:value-of select="placeName"/>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="@type"/>
                <xsl:text>), </xsl:text>
                <xsl:if test="settlement">
                    <xsl:value-of select="settlement"/>
                    <xsl:text>, </xsl:text>
                </xsl:if>
                <xsl:value-of select="region"/>
                <xsl:text>, </xsl:text>
                <xsl:value-of select="country"/>
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template name="person">
        <xsl:for-each select="//listPerson/person">
            <xsl:sort/>
            <li>
                <xsl:if test="persName/element()">
                    <xsl:value-of select="persName/forename"/>
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="persName/surname"/></xsl:if>
                <xsl:if test="persName/text()">
                    <xsl:value-of select="persName"/>
                </xsl:if>
            </li>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="publicationStmt">
        <xsl:for-each select="element()">
            <xsl:value-of select="text()"/>
            <xsl:choose>
                <xsl:when test="position() = last()">.</xsl:when>
                <xsl:otherwise>, </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="msIdentifier">
        <xsl:for-each select="element()">
            <xsl:value-of select="text()"/>
            <xsl:choose>
                <xsl:when test="position() = last()">.</xsl:when>
                <xsl:otherwise>, </xsl:otherwise>
            </xsl:choose></xsl:for-each>
    </xsl:template>
    
    <xsl:template match="langUsage">
        <xsl:for-each select="language">
            <xsl:sort/>
            <xsl:value-of select="text()"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="@usage"/>
            <xsl:text> %</xsl:text>
            <xsl:choose>
                <xsl:when test="position() != last()">; </xsl:when>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>