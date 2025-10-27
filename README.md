# AnIML XML Schemas

Welcome to the **Analytical Information Markup Language (AnIML)**.

## Overview

AnIML is an ASTM standard XML format designed for representing analytical chemistry data and metadata. It provides a vendor-neutral, open format for storing and exchanging analytical data across different laboratory information systems, instruments, and software applications.

This repository contains the official AnIML schema definitions:
- **AnIML Core Schema** (`animl-core.xsd`) - Defines the core structure for AnIML documents
- **AnIML Technique Schema** (`animl-technique.xsd`) - Defines technique-specific extensions and blueprints

## Key Features

### Data Management
- **Sample Management**: Define and track samples throughout analytical workflows
- **Experiment Steps**: Document complete experimental procedures and methodologies
- **Results Storage**: Capture analytical results with full metadata and series data
- **Data Integrity**: Built-in support for audit trails and features commonly required for regulatory compliance

### Security & Compliance
- **Audit Trails**: Track all changes made to AnIML documents with timestamps and user information
- **Digital Signatures**: W3C XML-DSIG compliant digital signature support for data authentication
- **Traceability**: Complete documentation of data lineage and sample derivation

### Flexibility
- **Technique Definitions**: Extensible framework for defining analytical techniques
- **Method Blueprints**: Standardized templates for analytical methods
- **Multi-technique Support**: Handle diverse analytical techniques from spectroscopy to chromatography

## Schema Components

### Core Schema (animl-core.xsd)
The Core Schema defines the fundamental structure of AnIML documents:
- `AnIML` - Root element for all AnIML documents
- `SampleSet` - Container for sample definitions
- `ExperimentStepSet` - Container for experimental procedures and results
- `AuditTrailEntrySet` - Container for audit trail entries
- `SignatureSet` - Container for digital signatures

### Technique Schema (animl-technique.xsd)
The Technique Schema provides a framework for defining specific analytical techniques:
- `Technique` - Root element for technique definition documents
- `SampleRoleBlueprint` - Defines expected sample roles
- `MethodBlueprint` - Defines method parameters and structure
- `ResultBlueprint` - Defines expected result structure
- `Bibliography` - Literature references for the technique

## Use Cases

AnIML is widely used in:
- Pharmaceutical laboratories for drug development and quality control
- Chemical analysis laboratories
- Contract research organizations (CROs)
- Regulatory submissions requiring analytical data
- Laboratory Information Management Systems (LIMS)
- Electronic Laboratory Notebooks (ELN)
- Analytical instrument data systems

## Version

Current schema version: **0.90** (Draft)

## Learn More

Visit [www.animl.org](http://www.animl.org) for additional resources, documentation, and community information.

## License & Standards

AnIML is developed and maintained under the ASTM (American Society for Testing and Materials) standardization process.
