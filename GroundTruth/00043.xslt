<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:alto="http://www.loc.gov/standards/alto/ns-v4#">
    <xsl:output method="html" indent="yes" />
    <xsl:template match="/">
        <html>
            <head>
                <title>Test</title>
            </head>
            <body>
                <table border="1">
                    <tr>
                        <th>ID de la ligne</th>
                        <th>Coordonnées du Polygone</th>
                    </tr>
                    <xsl:for-each select="//alto:TextLine">
                        <tr>
                            <td>
                                <xsl:value-of select="@ID" />
                            </td>
                            <td>
                                <xsl:value-of select="alto:Shape/alto:Polygon/@POINTS" />
                            </td>
                        </tr>
                    </xsl:for-each>
                </table>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>