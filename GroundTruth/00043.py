from lxml import etree

def transform_xml_to_xhtml(xml_path, xslt_path):
    # Load XML
    xml_tree = etree.parse(xml_path)

    # Load XSLT as bytes
    with open(xslt_path, 'rb') as f:  # Note 'rb' mode for reading as bytes
        xslt_content = f.read()
    xslt_tree = etree.XML(xslt_content)
    transform = etree.XSLT(xslt_tree)

    # Perform the transformation
    result_tree = transform(xml_tree)

    # Print or save the result
    result_str = str(result_tree)
    print(result_str)
    
    # Optionally, save to file
    with open('00043.xhtml', 'w') as f:
        f.write(result_str)

# Provide paths to your XML and XSLT files
transform_xml_to_xhtml('00043.xml', '00043.xslt')
