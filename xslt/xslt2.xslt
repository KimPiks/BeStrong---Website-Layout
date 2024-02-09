<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="site">
      <xsl:element name="site">
        <xsl:element name="plany">
          <xsl:apply-templates select="training_plans"/>
        </xsl:element>

        <xsl:element name="dieta">
          <xsl:apply-templates select="diet"/>
        </xsl:element>
      </xsl:element>
    </xsl:template>

    <xsl:template match="diet">
      <xsl:apply-templates select="macro_list"/>
    </xsl:template>

    <xsl:template match="macro_list">
      <xsl:copy>
        <xsl:apply-templates select="macro_element"/>
      </xsl:copy>
    </xsl:template>

    <xsl:template match="macro_element">
      <xsl:element name="{@element}">
        <xsl:element name="min">
          <xsl:copy-of select="@min_amount"/>
        </xsl:element>
        <xsl:element name="max">
          <xsl:copy-of select="@max_amount"/>
        </xsl:element>
      </xsl:element>
    </xsl:template>

    <xsl:template match="training_plans">
      <xsl:apply-templates select="training_plan"/>
    </xsl:template>

    <xsl:template match="training_plan">
      <xsl:element name="plan">
        <xsl:attribute name="{@plan_type}">true</xsl:attribute>
        <xsl:apply-templates select="day"/>
      </xsl:element>
    </xsl:template>

    <xsl:template match="day">
      <xsl:element name="dzien">
        <xsl:attribute name="numer"><xsl:value-of select="@n"/></xsl:attribute>
        <xsl:attribute name="wolne">
          <xsl:choose>
            <xsl:when test="@rest_day = 'true'">Tak</xsl:when>
            <xsl:otherwise>Nie</xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:apply-templates select="body_part"/>
      </xsl:element>
    </xsl:template>

    <xsl:template match="body_part">
      <xsl:element name="partia_ciala">
        <xsl:value-of select="."/>
      </xsl:element>
    </xsl:template>
</xsl:stylesheet>