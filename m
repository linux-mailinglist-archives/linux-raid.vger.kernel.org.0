Return-Path: <linux-raid+bounces-1181-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 412AF87EF70
	for <lists+linux-raid@lfdr.de>; Mon, 18 Mar 2024 19:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE961F2263C
	for <lists+linux-raid@lfdr.de>; Mon, 18 Mar 2024 18:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5403955C3F;
	Mon, 18 Mar 2024 18:03:01 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966F55E45
	for <linux-raid@vger.kernel.org>; Mon, 18 Mar 2024 18:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710784981; cv=none; b=HDd9ZpQDwrXJl7crWfAzUWomKbIcUHPfqYc52I6vMfDbddeQoz/toyHsScvd0Ys3tUpP0r68IeWbZRXhL7KGFE4VyO6aImusPrN+bgwBoqjcJYWNgK6/S2elSljzh76+5Y296lkcnxrCt3r9TUri1Rpn53JF1NVfGkduBbJJs8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710784981; c=relaxed/simple;
	bh=+ASLhKRZirrRncIHqAoFwL1vlCvIAGHibfj7bRpBnAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABrw+Jz8/U0KwFELVZm7itKPeQc19Q6F7Td8qFmrFGdrhjRKuYVfSZ8RtPX3VIy/eTdp1wFzQU+or3VnTwgpPxASBiFz/nMYvS8Tjbk5Azc577LNnHcsKoW9vCsgm2zrLY2TXQFiWDQ179NuDMmjtCoUJ/RutpLJ1+7aW1UTIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.178.112] (p57b378ee.dip0.t-ipconnect.de [87.179.120.238])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6531761E5FE01;
	Mon, 18 Mar 2024 18:56:43 +0100 (CET)
Message-ID: <99cc0872-83f9-4c37-8050-9cbf95ace2c5@molgen.mpg.de>
Date: Mon, 18 Mar 2024 18:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] Add reading Opal NVMe encryption information
Content-Language: en-US
To: Blazej Kucman <blazej.kucman@intel.com>
Cc: mariusz.tkaczyk@linux.intel.com, jes@trained-monkey.org,
 linux-raid@vger.kernel.org
References: <20240318162535.13674-1-blazej.kucman@intel.com>
 <20240318162535.13674-2-blazej.kucman@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240318162535.13674-2-blazej.kucman@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Blazej,


Am 18.03.24 um 17:25 schrieb Blazej Kucman:
> For NVMe devices with Opal support, encryption information, status and
> ability are completed based on Opal Level 0 discovery response.

What do you mean by “are completed”?

> Technical documentation used is given in the implementation.
> 
> Ability in general describes what type of encryption is supported,
> Status describes in what state the disk with encryption support is.
> The current patch only includes only the implementation of reading

One *only* is enough?

> encryption information, functions will be used in one of
> the next patches.
> 
> Motivation for adding this functionality is to block mixing of disks
> in IMSM arrays with encryption enabled and disabled.
> The main goal is to not allow stealing data by rebuilding array to not
> encrypted drive which can be read elsewhere.

I wouldn’t wrap the line, just because a sentence ends.

> Value ENA_OTHER from enum encryption_ability will be used
> in the next patch.
> 
> Additionally, pr_vrb define is moved from super-intel.c to mdadm.h
> so that it can be used globally.

Using “Additionally” in a commit message is a good indicator to make it 
a separate commit. ;-)

> Signed-off-by: Blazej Kucman <blazej.kucman@intel.com>
> ---
>   Makefile           |   4 +-
>   drive_encryption.c | 362 +++++++++++++++++++++++++++++++++++++++++++++
>   drive_encryption.h |  32 ++++
>   mdadm.h            |   2 +
>   super-intel.c      |   2 -
>   5 files changed, 398 insertions(+), 4 deletions(-)
>   create mode 100644 drive_encryption.c
>   create mode 100644 drive_encryption.h
> 
> diff --git a/Makefile b/Makefile
> index cbdba49a..7c221a89 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -170,7 +170,7 @@ OBJS = mdadm.o config.o policy.o mdstat.o  ReadMe.o uuid.o util.o maps.o lib.o u
>          mdopen.o super0.o super1.o super-ddf.o super-intel.o bitmap.o \
>          super-mbr.o super-gpt.o \
>          restripe.o sysfs.o sha1.o mapfile.o crc32.o sg_io.o msg.o xmalloc.o \
> -       platform-intel.o probe_roms.o crc32c.o
> +       platform-intel.o probe_roms.o crc32c.o drive_encryption.o
>   
>   CHECK_OBJS = restripe.o uuid.o sysfs.o maps.o lib.o xmalloc.o dlink.o
>   
> @@ -183,7 +183,7 @@ MON_OBJS = mdmon.o monitor.o managemon.o uuid.o util.o maps.o mdstat.o sysfs.o c
>   	Kill.o sg_io.o dlink.o ReadMe.o super-intel.o \
>   	super-mbr.o super-gpt.o \
>   	super-ddf.o sha1.o crc32.o msg.o bitmap.o xmalloc.o \
> -	platform-intel.o probe_roms.o crc32c.o
> +	platform-intel.o probe_roms.o crc32c.o drive_encryption.o
>   
>   MON_SRCS = $(patsubst %.o,%.c,$(MON_OBJS))
>   
> diff --git a/drive_encryption.c b/drive_encryption.c
> new file mode 100644
> index 00000000..0fa214a9
> --- /dev/null
> +++ b/drive_encryption.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Read encryption information for Opal and ATA devices.
> + *
> + * Copyright (C) 2024 Intel Corporation
> + *	Author: Blazej Kucman <blazej.kucman@intel.com>
> + */
> +
> +#include "mdadm.h"
> +
> +#include <asm/types.h>
> +#include <linux/nvme_ioctl.h>
> +#include "drive_encryption.h"
> +
> +/*
> + * Opal defines
> + * TCG Storage Opal SSC 2.01 chapter 3.3.3
> + * NVM ExpressTM Revision 1.4c, chapter 5
> + */
> +#define TCG_SECP_01 (0x01)
> +#define TCG_SECP_00 (0x00)
> +#define OPAL_DISCOVERY_COMID (0x0001)
> +#define OPAL_LOCKING_FEATURE (0x0002)
> +#define OPAL_IO_BUFFER_LEN 2048
> +#define OPAL_DISCOVERY_FEATURE_HEADER_LEN (4)
> +
> +/*
> + * NVMe defines
> + * NVM ExpressTM Revision 1.4c, chapter 5
> + */
> +#define NVME_SECURITY_RECV (0x82)
> +#define NVME_IDENTIFY (0x06)
> +#define NVME_IDENTIFY_RESPONSE_LEN 4096
> +#define NVME_OACS_BYTE_POSITION (256)
> +#define NVME_IDENTIFY_CONTROLLER_DATA (1)
> +
> +typedef enum drive_feature_support_status {
> +	/* Drive feature is supported. */
> +	DRIVE_FEAT_SUP_ST = 0,
> +	/* Drive feature is not supported. */
> +	DRIVE_FEAT_NOT_SUP_ST,
> +	/* Drive feature support check failed. */
> +	DRIVE_FEAT_CHECK_FAILED_ST
> +} drive_feat_sup_st;
> +
> +/* TCG Storage Opal SSC 2.01 chapter 3.1.1.3 */
> +typedef struct opal_locking_feature {
> +	/* feature header */
> +	__u16 feature_code;
> +	__u8 reserved : 4;
> +	__u8 version : 4;
> +	__u8 description_length;
> +	/* feature description */
> +	__u8 locking_supported : 1;
> +	__u8 locking_enabled : 1;
> +	__u8 locked : 1;
> +	__u8 media_encryption : 1;
> +	__u8 mbr_enabled : 1;
> +	__u8 mbr_done : 1;
> +	__u8 mbr_shadowing_not_supported : 1;
> +	__u8 hw_reset_for_dor_supported : 1;
> +	__u8 reserved1[11];
> +} __attribute__((__packed__)) opal_locking_feature_t;
> +
> +/* TCG Storage Opal SSC 2.01 chapter 3.1.1.1 */
> +typedef struct opal_level0_header {
> +	__u32 length;
> +	__u32 version;
> +	__u64 reserved;
> +	__u8 vendor_specific[32];
> +} opal_level0_header_t;
> +
> +/**
> + * NVM ExpressTM Revision 1.4c, Figure 249
> + * Structure specifies only OACS filed, which is needed in the current use case.
> + */
> +typedef struct nvme_identify_ctrl {
> +	__u8 reserved[255];
> +	__u16 oacs;
> +	__u8 reserved2[3839];
> +} nvme_identify_ctrl_t;
> +
> +/* SCSI Primary Commands - 4 (SPC-4), Table 512 */
> +typedef struct supported_security_protocols {
> +	__u8  reserved[6];
> +	__u16 list_length;
> +	__u8  list[504];
> +} supported_security_protocols_t;
> +
> +/**
> + * get_opal_locking_feature_description() - get opal locking feature description.
> + * @response: response from Opal Discovery Level 0.
> + *
> + * Based on the documentation TCG Storage Opal SSC 2.01 chapter 3.1.1,
> + * a Locking feature is searched for in Opal Level 0 Discovery response.
> + *
> + * Return: if locking feature found pointer to struct %opal_locking_feature_t, NULL otherwise.

is found?

> + */
> +static opal_locking_feature_t *get_opal_locking_feature_description(__u8 *response)
> +{
> +	opal_level0_header_t *response_header = (opal_level0_header_t *)response;
> +	int features_length = __be32_to_cpu(response_header->length);
> +	int current_position = sizeof(*response_header);
> +
> +	while (current_position < features_length) {
> +		opal_locking_feature_t *feature;
> +
> +		feature = (opal_locking_feature_t *)(response + current_position);
> +
> +		if (__be16_to_cpu(feature->feature_code) == OPAL_LOCKING_FEATURE)
> +			return feature;
> +
> +		current_position += feature->description_length + OPAL_DISCOVERY_FEATURE_HEADER_LEN;
> +	}
> +
> +	return NULL;
> +}
> +
> +/**
> + * nvme_security_recv_ioctl() - nvme security receive ioctl.
> + * @disk_fd: a disk file descriptor.
> + * @sec_protocol: security protocol.
> + * @comm_id: command id.
> + * @response_buffer: response buffer to fill out.
> + * @buf_size: response buffer size.
> + * @verbose: verbose flag.
> + *
> + * Based on the documentations TCG Storage Opal SSC 2.01 chapter 3.3.3 and
> + * NVM ExpressTM Revision 1.4c, chapter 5.25,
> + * read security receive command via ioctl().
> + * On success, @response_buffer is completed.
> + *
> + * Return: %MDADM_STATUS_SUCCESS on success, %MDADM_STATUS_ERROR otherwise.
> + */
> +static mdadm_status_t
> +nvme_security_recv_ioctl(int disk_fd, __u8 sec_protocol, __u16 comm_id, void *response_buffer,
> +			 size_t buf_size, const int verbose)
> +{
> +	struct nvme_admin_cmd nvme_cmd = {0};
> +	int status;
> +
> +	nvme_cmd.opcode = NVME_SECURITY_RECV;
> +	nvme_cmd.cdw10 = sec_protocol << 24 | comm_id << 8;
> +	nvme_cmd.cdw11 = buf_size;
> +	nvme_cmd.data_len = buf_size;
> +	nvme_cmd.addr = (__u64)response_buffer;
> +
> +	status = ioctl(disk_fd, NVME_IOCTL_ADMIN_CMD, &nvme_cmd);
> +	if (status != 0) {
> +		pr_vrb("Failed to read NVMe security receive ioctl() for device /dev/%s, status: %d\n",
> +		       fd2kname(disk_fd), status);
> +		return MDADM_STATUS_ERROR;
> +	}
> +
> +	return MDADM_STATUS_SUCCESS;
> +}
> +
> +/**
> + * nvme_identify_ioctl() - NVMe identify ioctl.
> + * @disk_fd: a disk file descriptor.
> + * @response_buffer: response buffer to fill out.
> + * @buf_size: response buffer size.
> + * @verbose: verbose flag.
> + *
> + * Based on the documentations TCG Storage Opal SSC 2.01 chapter 3.3.3 and
> + * NVM ExpressTM Revision 1.4c, chapter 5.25,
> + * read NVMe identify via ioctl().
> + * On success, @response_buffer will be completed.
> + *
> + * Return: %MDADM_STATUS_SUCCESS on success, %MDADM_STATUS_ERROR otherwise.
> + */
> +static mdadm_status_t
> +nvme_identify_ioctl(int disk_fd, void *response_buffer, size_t buf_size, const int verbose)
> +{
> +	struct nvme_admin_cmd nvme_cmd = {0};
> +	int status;
> +
> +	nvme_cmd.opcode = NVME_IDENTIFY;
> +	nvme_cmd.cdw10 = NVME_IDENTIFY_CONTROLLER_DATA;
> +	nvme_cmd.data_len = buf_size;
> +	nvme_cmd.addr = (__u64)response_buffer;
> +
> +	status = ioctl(disk_fd, NVME_IOCTL_ADMIN_CMD, &nvme_cmd);
> +	if (status != 0) {
> +		pr_vrb("Failed to read NVMe identify ioctl() for device /dev/%s, status: %d\n",
> +		       fd2kname(disk_fd), status);
> +		return MDADM_STATUS_ERROR;
> +	}
> +
> +	return MDADM_STATUS_SUCCESS;
> +}
> +
> +/**
> + * is_sec_prot_01h_supported() - check if security protocol 01h supported.
> + * @security_protocols: struct with response from disk (NVMe, SATA) describing supported
> + * security protocols.
> + *
> + * Return: true if TCG_SECP_01 found, false otherwise.
> + */
> +static bool is_sec_prot_01h_supported(supported_security_protocols_t *security_protocols)
> +{
> +	int list_length = be16toh(security_protocols->list_length);
> +	int index;
> +
> +	for (index = 0 ; index < list_length; index++) {
> +		if (security_protocols->list[index] == TCG_SECP_01)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +/**
> + * is_sec_prot_01h_supported_nvme() - check if security protocol 01h supported for given NVMe disk.
> + * @disk_fd: a disk file descriptor.
> + * @verbose: verbose flag.
> + *
> + * Return: %DRIVE_FEAT_SUP_ST if TCG_SECP_01 supported, %DRIVE_FEAT_NOT_SUP_ST if not supported,
> + * %DRIVE_FEAT_CHECK_FAILED_ST if failed to check.
> + */
> +static drive_feat_sup_st is_sec_prot_01h_supported_nvme(int disk_fd, const int verbose)
> +{
> +	supported_security_protocols_t security_protocols = {0};
> +
> +	/* security_protocol: TCG_SECP_00, comm_id: not applicable */
> +	if (nvme_security_recv_ioctl(disk_fd, TCG_SECP_00, 0x0, &security_protocols,
> +				     sizeof(security_protocols), verbose))
> +		return DRIVE_FEAT_CHECK_FAILED_ST;
> +
> +	if (is_sec_prot_01h_supported(&security_protocols))
> +		return DRIVE_FEAT_SUP_ST;
> +
> +	return DRIVE_FEAT_NOT_SUP_ST;
> +}
> +
> +/**
> + * is_nvme_sec_send_recv_supported() - check if Security Send and Security Receive is supported.
> + * @disk_fd: a disk file descriptor.
> + * @verbose: verbose flag.
> + *
> + * Check if "Optional Admin Command Support" bit 0 is set in NVMe identify.
> + * Bit 0 set to 1 means controller supports the Security Send and Security Receive commands.
> + *
> + * Return: %DRIVE_FEAT_SUP_ST if security send/receive supported,
> + * %DRIVE_FEAT_NOT_SUP_ST if not supported, %DRIVE_FEAT_CHECK_FAILED_ST if check failed.
> + */
> +static drive_feat_sup_st is_nvme_sec_send_recv_supported(int disk_fd, const int verbose)
> +{
> +	nvme_identify_ctrl_t nvme_identify = {0};
> +	int status = 0;
> +
> +	status = nvme_identify_ioctl(disk_fd, &nvme_identify, sizeof(nvme_identify), verbose);
> +	if (status)
> +		return DRIVE_FEAT_CHECK_FAILED_ST;
> +
> +	if ((__le16_to_cpu(nvme_identify.oacs) & 0x1) == 0x1)
> +		return DRIVE_FEAT_SUP_ST;
> +
> +	return DRIVE_FEAT_NOT_SUP_ST;
> +}
> +
> +/**
> + * get_opal_encryption_locking_informations() - get Opal Locking information.

There is no plural for *information*.

> + * @buffer: buffer with Opal Level 0 Discovery response.
> + * @information: struct to fill out, describing encryption status of disk.
> + *
> + * If Locking feature frame is in response from Opal Level 0 discovery, &encryption_information_t
> + * structure is completed with status and ability otherwise the status is set to &None.
> + * For possible encryption statuses and abilities,
> + * please refer to enums &encryption_status and &encryption_ability.
> + *
> + * Return: %MDADM_STATUS_SUCCESS on success, %MDADM_STATUS_ERROR otherwise.
> + */
> +static mdadm_status_t get_opal_encryption_informations(__u8 *buffer,
> +						       encryption_information_t *information)
> +{
> +	opal_locking_feature_t *opal_locking_feature =
> +					get_opal_locking_feature_description(buffer);
> +
> +	if (!opal_locking_feature)
> +		return MDADM_STATUS_ERROR;
> +
> +	if (opal_locking_feature->locking_supported == 1) {
> +		information->ability = ENA_SED;
> +
> +		if (opal_locking_feature->locking_enabled == 0)
> +			information->status = ENS_UNENCRYPTED;
> +		else if (opal_locking_feature->locked == 1)
> +			information->status = ENS_LOCKED;
> +		else
> +			information->status = ENS_UNLOCKED;
> +	} else {
> +		information->ability = ENA_NONE;
> +		information->status = ENS_UNENCRYPTED;
> +	}
> +
> +	return MDADM_STATUS_SUCCESS;
> +}
> +
> +/**
> + * get_nvme_opal_encryption_informations() - get NVMe Opal encryption information.
> + * @disk_fd: a disk file descriptor.
> + * @information: struct to fill out, describing encryption status of disk.
> + * @verbose: verbose flag.
> + *
> + * In case the disk supports Opal Level 0 discovery, &encryption_information_t structure
> + * is completed with status and ability based on ioctl response,
> + * otherwise the ability is set to %ENA_NONE and &status to %ENS_UNENCRYPTED.
> + * As the current use case does not need the knowledge of Opal support, if there is no support,
> + * %MDADM_STATUS_SUCCESS will be returned, with the values described above.
> + * For possible encryption statuses and abilities,
> + * please refer to enums &encryption_status and &encryption_ability.
> + *
> + * %MDADM_STATUS_SUCCESS on success, %MDADM_STATUS_ERROR otherwise.
> + */
> +mdadm_status_t
> +get_nvme_opal_encryption_informations(int disk_fd, encryption_information_t *information,
> +				      const int verbose)
> +{
> +	__u8 buffer[OPAL_IO_BUFFER_LEN];
> +	int sec_send_recv_supported = 0;
> +	int protocol_01h_supported = 0;
> +	mdadm_status_t status;
> +
> +	information->ability = ENA_NONE;
> +	information->status = ENS_UNENCRYPTED;
> +
> +	sec_send_recv_supported = is_nvme_sec_send_recv_supported(disk_fd, verbose);
> +	if (sec_send_recv_supported == DRIVE_FEAT_CHECK_FAILED_ST)
> +		return MDADM_STATUS_ERROR;
> +
> +	/* Opal not supported */
> +	if (sec_send_recv_supported == DRIVE_FEAT_NOT_SUP_ST)
> +		return MDADM_STATUS_SUCCESS;
> +
> +	/**
> +	 * sec_send_recv_supported determine that it should be possible to read
> +	 * supported sec protocols
> +	 */
> +	protocol_01h_supported = is_sec_prot_01h_supported_nvme(disk_fd, verbose);
> +	if (protocol_01h_supported == DRIVE_FEAT_CHECK_FAILED_ST)
> +		return MDADM_STATUS_ERROR;
> +
> +	/* Opal not supported */
> +	if (sec_send_recv_supported == DRIVE_FEAT_SUP_ST &&
> +	    protocol_01h_supported == DRIVE_FEAT_NOT_SUP_ST)
> +		return MDADM_STATUS_SUCCESS;
> +
> +	if (nvme_security_recv_ioctl(disk_fd, TCG_SECP_01, OPAL_DISCOVERY_COMID, (void *)&buffer,
> +				     OPAL_IO_BUFFER_LEN, verbose))
> +		return MDADM_STATUS_ERROR;
> +
> +	status = get_opal_encryption_informations((__u8 *)&buffer, information);
> +	if (status)
> +		pr_vrb("Locking feature description not found in Level 0 discovery response. Device /dev/%s.\n",
> +		       fd2kname(disk_fd));
> +
> +	if (information->ability == ENA_NONE)
> +		assert(information->status == ENS_UNENCRYPTED);
> +
> +	return status;
> +}
> diff --git a/drive_encryption.h b/drive_encryption.h
> new file mode 100644
> index 00000000..27f1de55
> --- /dev/null
> +++ b/drive_encryption.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Read encryption information for Opal and ATA devices.
> + *
> + * Copyright (C) 2024 Intel Corporation
> + *	Author: Blazej Kucman <blazej.kucman@intel.com>
> + */
> +
> +typedef enum encryption_status {
> +	/* The drive is not currently encrypted. */
> +	ENS_UNENCRYPTED = 0,

I’d user longer names like `ENC_STATUS_`.

> +	/* The drive is encrypted and the data is not accessible. */
> +	ENS_LOCKED,
> +	/* The drive is encrypted but the data is accessible in unencrypted form. */
> +	ENS_UNLOCKED
> +} encryption_status_t;
> +
> +typedef enum encryption_ability {
> +	ENA_NONE = 0,
> +	ENA_OTHER,
> +	/* Self encrypted drive */
> +	ENA_SED
> +} encryption_ability_t;
> +
> +typedef struct encryption_information {
> +	encryption_ability_t ability;
> +	encryption_status_t status;
> +} encryption_information_t;
> +
> +mdadm_status_t
> +get_nvme_opal_encryption_informations(int disk_fd, struct encryption_information *information,
> +				      const int verbose);
> diff --git a/mdadm.h b/mdadm.h
> index 3fedca48..141adbd7 100644
> --- a/mdadm.h
> +++ b/mdadm.h
> @@ -1912,6 +1912,8 @@ static inline int xasprintf(char **strp, const char *fmt, ...) {
>   
>   #define pr_info(fmt, args...) printf("%s: "fmt, Name, ##args)
>   
> +#define pr_vrb(fmt, arg...) ((void)(verbose && pr_err(fmt, ##arg)))
> +
>   void *xmalloc(size_t len);
>   void *xrealloc(void *ptr, size_t len);
>   void *xcalloc(size_t num, size_t size);
> diff --git a/super-intel.c b/super-intel.c
> index 77140455..806b6248 100644
> --- a/super-intel.c
> +++ b/super-intel.c
> @@ -393,8 +393,6 @@ struct md_list {
>   	struct md_list *next;
>   };
>   
> -#define pr_vrb(fmt, arg...) (void) (verbose && pr_err(fmt, ##arg))
> -
>   static __u8 migr_type(struct imsm_dev *dev)
>   {
>   	if (dev->vol.migr_type == MIGR_VERIFY &&


Kind regards,

Paul

