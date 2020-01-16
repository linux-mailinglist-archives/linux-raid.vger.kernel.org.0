Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F248F13F662
	for <lists+linux-raid@lfdr.de>; Thu, 16 Jan 2020 20:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbgAPTDs (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Thu, 16 Jan 2020 14:03:48 -0500
Received: from sender11-of-f72.zoho.eu ([31.186.226.244]:17350 "EHLO
        sender21-op-o12.zoho.eu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388803AbgAPTDs (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Thu, 16 Jan 2020 14:03:48 -0500
Received: from [172.30.220.41] (163.114.130.128 [163.114.130.128]) by mx.zoho.eu
        with SMTPS id 1579200518826372.4858963527155; Thu, 16 Jan 2020 19:48:38 +0100 (CET)
Subject: Re: [PATCH, v2] Change warning message
To:     Kinga Tanska <kinga.tanska@intel.com>, linux-raid@vger.kernel.org
References: <20191210112121.20377-1-kinga.tanska@intel.com>
From:   Jes Sorensen <jes@trained-monkey.org>
Message-ID: <b48dd5ba-639b-eba5-5386-899d317d3676@trained-monkey.org>
Date:   Thu, 16 Jan 2020 13:48:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191210112121.20377-1-kinga.tanska@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 12/10/19 6:21 AM, Kinga Tanska wrote:
> In commit 039b7225e6 ("md: allow creation of mdNNN arrays via
> md_mod/parameters/new_array") support for name like mdNNN
> was added. Special warning, when kernel is unable to handle
> request, was added in commit 7105228e19
> ("mdadm/mdopen: create new function create_named_array for
> writing to new_array"), but it was not adequate enough,
> because in this situation mdadm tries to do it in old way.
> This commit changes warning to be more relevant when
> creating RAID container with "/dev/mdNNN" name and mdadm
> back to old approach.
> 
> Signed-off-by: Kinga Tanska <kinga.tanska@intel.com>

Applied!

Thanks,
Jes


